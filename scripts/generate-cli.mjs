import ts from 'typescript';
import {readFile, writeFile} from 'node:fs/promises';
import assert from 'node:assert/strict';
const spec=JSON.parse(await readFile('fern/openapi/openapi.json','utf8'));
const operations=[];
for(const [path,item] of Object.entries(spec.paths)) for(const verb of ['get','post','put','patch','delete']) {
 const op=item[verb]; if(!op || op['x-fern-ignore']) continue;
 const group=op['x-fern-sdk-group-name'], method=op['x-fern-sdk-method-name'];
 const source=ts.createSourceFile('Client.ts',await readFile(`sdk/typescript/src/api/resources/${group}/client/Client.ts`,'utf8'),ts.ScriptTarget.Latest,true);
 let params;
 function visit(node){if(ts.isMethodDeclaration(node)&&node.name.getText(source)===method) params=node.parameters.filter(p=>p.name.getText(source)!=='requestOptions').map(p=>({name:p.name.getText(source),required:!p.questionToken&&!p.initializer}));ts.forEachChild(node,visit);}
 visit(source);assert.ok(params,`Missing generated method ${group}.${method}`);
 operations.push({name:`${group}.${method}`,group,method,verb:verb.toUpperCase(),path,summary:op.summary??op.description??'',parameters:params,requestSchema:op.requestBody?.content?.['application/json']?.schema,query:(op.parameters??[]).filter(p=>p.in==='query')});
}
operations.sort((a,b)=>a.name.localeCompare(b.name));
const output='// Generated from reviewed OpenAPI and Fern signatures by scripts/generate-cli.mjs.\nexport const operations = '+JSON.stringify(operations,null,2)+' as const;\n';
if(process.argv.includes('--check')) assert.equal(await readFile('cli/operations.ts','utf8'),output,'Run npm run cli:generate');
else await writeFile('cli/operations.ts',output);
console.log(`CLI covers ${operations.length} Fern operations.`);
