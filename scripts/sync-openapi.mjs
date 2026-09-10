import {readFile, writeFile} from 'node:fs/promises';
import {parse} from 'yaml';

const source = new URL('../fern/openapi/upstream.yaml', import.meta.url);
const output = new URL('../fern/openapi/openapi.json', import.meta.url);
const live = process.argv.includes('--live');
const check = process.argv.includes('--check');
// Public spec retrieval carries no credentials; permit the site's canonical-host redirect.
const text = live ? await fetch('https://agenttrunk.ai/openapi.yaml', {redirect: 'follow', signal: AbortSignal.timeout(30_000)}).then(async response => {
  if (!response.ok) throw new Error(`OpenAPI fetch failed: ${response.status}`);
  return response.text();
}) : await readFile(source, 'utf8');
const document = parse(text);
if (document.openapi !== '3.1.0' || document.info?.title !== 'AgentTrunk API') throw new Error('Unexpected public API contract');

// Discovery uses compact contextKey metadata, not the full Context record's key/id/createdAt.
// This matches the existing public client wire contract and its fixtures.
document.components.schemas.DiscoveryResult = {
  type: 'object',
  required: ['trunkId', 'scopeId', 'contextKey', 'title', 'kind', 'summary', 'tags', 'revisionId', 'packageDigest', 'channel', 'updatedAt'],
  properties: {
    trunkId: {type: 'string'}, scopeId: {type: 'string'}, contextKey: {type: 'string'},
    title: {type: 'string'}, kind: {$ref: '#/components/schemas/ContextKind'}, summary: {type: 'string'},
    tags: {type: 'array', items: {type: 'string'}}, revisionId: {type: 'string', pattern: '^[a-f0-9]{64}$'},
    packageDigest: {type: 'string'}, channel: {type: 'string', enum: ['production', 'staging', 'latest']},
    updatedAt: {type: 'string', format: 'date-time'},
  },
};
// A string with validation preserves the wire format without language-specific union wrappers.
document.components.parameters.RevisionRef.schema = {
  type: 'string', default: 'production', pattern: '^(production|staging|latest|[a-f0-9]{64})$',
};
const fileRead = document.paths['/v1/trunks/{trunkId}/contexts/{contextKey}/files/{resourcePath}'].get;
fileRead.parameters = fileRead.parameters.map(parameter => parameter.$ref === '#/components/parameters/RevisionRef'
  ? {name: 'ref', in: 'query', required: true, description: 'Immutable revision ID from inspect; resolve moving channels before reading.', schema: {type: 'string', pattern: '^[a-f0-9]{64}$'}} : parameter);

const naming = {
  listTrunks: ['workspaces', 'list'], createTrunk: ['workspaces', 'create'], getTrunk: ['workspaces', 'get'],
  listScopes: ['scopes', 'list'], createScope: ['scopes', 'create'],
  discoverContext: ['contexts', 'discover'], inspectContext: ['contexts', 'inspect'], readContextFile: ['contexts', 'readFile'],
  publishContextRevision: ['contexts', 'publish'], listContextHistory: ['contexts', 'history'], compareContextRevisions: ['contexts', 'compare'],
  getRevisionProvenance: ['contexts', 'getProvenance'], putRevisionProvenance: ['contexts', 'putProvenance'],
  getRollbackPlan: ['contexts', 'getRollbackPlan'], stageRollback: ['contexts', 'stageRollback'],
  shareContextItem: ['contexts', 'share'], editContext: ['contexts', 'edit'],
  listPromotionRequests: ['releases', 'list'], openPromotionRequest: ['releases', 'open'], mergePromotionRequest: ['releases', 'merge'],
  listAvailableContextSources: ['contextSets', 'sources'], listContextSets: ['contextSets', 'list'], createContextSet: ['contextSets', 'create'], resolveContextSet: ['contextSets', 'resolve'],
  listTrunkAudit: ['workspaces', 'audit'],
  listWebhookSubmissions: ['webhooks', 'list'], createWorkspaceWebhookPortal: ['webhooks', 'createPortal'], retryWebhookSubmission: ['webhooks', 'retry'],
  getBilling: ['billing', 'get'], createBillingCheckout: ['billing', 'createCheckout'], createBillingPortal: ['billing', 'createPortal'], setBillingSpendLimit: ['billing', 'setSpendLimit'],
  getHealth: ['health', 'get'],
};
const unnamed = {
  'POST /v1/trunks/{trunkId}/privacy-requests/{requestId}/review': ['privacy', 'assignReview'],
  'GET /v1/trunks/{trunkId}/erasure-plan': ['privacy', 'erasurePlan'],
  'GET /v1/trunks/{trunkId}/contexts/{contextKey}/export': ['contexts', 'export'],
  'GET /v1/trunks/{trunkId}/privacy-requests': ['privacy', 'list'],
  'POST /v1/trunks/{trunkId}/privacy-requests': ['privacy', 'create'],
};
const ref = name => ({$ref: `#/components/schemas/${name}`});
const page = name => ({type: 'object', required: ['data'], properties: {data: {type: 'array', items: ref(name)}, nextCursor: {type: ['string', 'null']}}});
// Public response descriptions specify these shapes; augment missing schemas without changing wire fields.
const responseSchemas = {
  getTrunk: ref('Trunk'), inspectContext: {type: 'object', required: ['context', 'revision'], properties: {context: ref('Context'), revision: ref('Revision')}},
  listPromotionRequests: page('PromotionRequest'),
  listContextHistory: {type: 'object', required: ['data'], properties: {data: {type: 'array', items: ref('Revision')}, next: {type: ['string', 'null']}}},
  createBillingCheckout: {type: 'object', required: ['url'], properties: {url: {type: 'string'}}},
  createBillingPortal: {type: 'object', required: ['url'], properties: {url: {type: 'string'}}},
  setBillingSpendLimit: {type: 'object', required: ['spendLimitCents'], properties: {spendLimitCents: {type: 'integer'}}},
};
let count = 0;
for (const [path, item] of Object.entries(document.paths)) {
  for (const method of ['get','post','put','patch','delete']) {
    const operation = item[method]; if (!operation) continue;
    if (operation.operationId === 'receiveStripeWebhook') {operation['x-fern-ignore'] = true; continue;}
    const names = naming[operation.operationId] ?? unnamed[`${method.toUpperCase()} ${path}`];
    if (!names) throw new Error(`Unmapped operation: ${method} ${path}`);
    for (const [status, response] of Object.entries(operation.responses ?? {})) {
      if (/^2\d\d$/.test(status) && !response.content && !response.$ref) {
        response.content = {'application/json': {schema: responseSchemas[operation.operationId] ?? {description: 'The public contract does not specify response fields; inspect the returned JSON.', type: 'object', additionalProperties: true}}};
      }
    }
    operation.operationId = names.join('_'); operation.tags = [names[0]];
    operation['x-fern-sdk-group-name'] = names[0]; operation['x-fern-sdk-method-name'] = names[1];
    count++;
  }
}
// Explicit bearer configuration avoids generating an unverified OAuth credential issuer.
document.components.securitySchemes = {bearerAuth: {type: 'http', scheme: 'bearer'}};
document.security = [{bearerAuth: []}];
const serialized = JSON.stringify(document, null, 2) + '\n';
if (check) {
  if (await readFile(output, 'utf8') !== serialized) throw new Error('OpenAPI snapshot differs; review and run sdk:sync (or sdk:sync:live for hosted updates).');
  console.log(`OpenAPI snapshot matches ${live ? 'hosted' : 'checked-in'} source (${count} operations).`);
} else {
  if (live) await writeFile(source, text);
  await writeFile(output, serialized);
  console.log(`Prepared ${count} SDK operations; Stripe receiver excluded.`);
}
