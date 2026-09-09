import { clientFromEnvironment, main, required } from '../shared.mjs';

// Two reviewed inline files: no directory traversal or accidental secret collection.
export function skillPackage(scopeId, contextKey) {
  return {
    scopeId, contextKey, title: 'Support response guidance', kind: 'skill',
    summary: 'Draft support responses and identify when escalation is needed.',
    tags: ['support', 'example'],
    files: [
      {path: 'SKILL.md', contentBase64: Buffer.from(`---
name: support-response
description: Draft a support response using the provided ticket and identify unresolved questions that need escalation.
---

# Support response

Draft from the facts in the supplied ticket. Follow [the escalation guide](references/escalation.md) for uncertain requests. Return a draft and unresolved questions to the calling runtime; this skill does not send messages.
`).toString('base64')},
      {path: 'references/escalation.md', contentBase64: Buffer.from('# Escalation guide\n\nIdentify missing facts. Do not invent account access, refund policy or a resolution. Ask the calling runtime to route unresolved questions to its support owner.\n').toString('base64')},
    ],
  };
}
export async function publishSkill(client, {workspaceId, scopeId, contextKey, write = false}) {
  if (!workspaceId || !scopeId || !contextKey) throw new Error('Workspace, scope and key are required');
  const input = skillPackage(scopeId, contextKey);
  if (!write) return {mode: 'preview', workspaceId, input, warning: 'Applying replaces the complete package at this key in staging.'};
  const staged = await client.publish(workspaceId, input);
  const inspected = await client.inspect(workspaceId, contextKey, staged.revision.id);
  if (inspected.revision.id !== staged.revision.id) throw new Error('Revision mismatch');
  if (inspected.revision.files.length !== input.files.length) throw new Error('Unexpected package manifest');
  for (const expected of input.files) {
    const file = inspected.revision.files.find(item => item.path === expected.path);
    if (!file) throw new Error('Missing published resource');
    const bytes = await client.readFile(workspaceId, contextKey, staged.revision.id, file);
    if (!Buffer.from(bytes).equals(Buffer.from(expected.contentBase64, 'base64'))) throw new Error('Published content mismatch');
  }
  return {mode: 'staged', workspaceId, contextKey, revisionId: staged.revision.id, packageDigest: staged.revision.packageDigest, verifiedFiles: input.files.length, productionChanged: false};
}
main(import.meta.url, () => {
  const write = process.env.AGENTTRUNK_WRITE === '1';
  return publishSkill(write ? clientFromEnvironment() : undefined, {
    workspaceId: required(process.env, 'AGENTTRUNK_WORKSPACE_ID'),
    scopeId: required(process.env, 'AGENTTRUNK_SCOPE_ID'),
    contextKey: required(process.env, 'AGENTTRUNK_CONTEXT_KEY'), write,
  });
});
