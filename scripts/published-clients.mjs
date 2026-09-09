const version=process.env.RELEASE_VERSION;
if(!version||!/^\d+\.\d+\.\d+(?:-[a-zA-Z0-9.-]+)?$/.test(version))throw Error('Exact release version required');
const targets=[['npm',`https://registry.npmjs.org/@agenttrunk%2fsdk/${version}`],['PyPI',`https://pypi.org/pypi/agenttrunk/${version}/json`],['crates.io',`https://crates.io/api/v1/crates/agenttrunk/${version}`],['RubyGems',`https://rubygems.org/api/v2/rubygems/agenttrunk/versions/${version}.json`]];
for(const [name,url]of targets){const response=await fetch(url,{redirect:'error',signal:AbortSignal.timeout(20000),headers:{'User-Agent':'agenttrunk-plugins-release-check'}});if(!response.ok)throw Error(`${name}: release unavailable (HTTP ${response.status})`);await response.body?.cancel();console.log(`${name}: release metadata available`);}
console.log('Metadata only. Install each artifact into a clean consumer before claiming release acceptance.');
