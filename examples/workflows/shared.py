import hashlib
import json
import os
import re
import sys
from agenttrunk import AgentTrunk

def kwargs(value):
    return {re.sub(r'[A-Z]', lambda m: '_' + m[0].lower(), key): val for key, val in value.items()}

def substitute(value):
    if isinstance(value, str):
        return re.sub(r'\$\{(AGENTTRUNK_[A-Z_]+)\}', lambda m: os.environ[m[1]], value)
    if isinstance(value, list): return [substitute(v) for v in value]
    if isinstance(value, dict): return {k: substitute(v) for k, v in value.items()}
    return value

def run(path, operation, execute):
    try:
        flags = sys.argv[1:]
        if any(flag not in ('--execute', '--yes') for flag in flags): raise ValueError('Invalid flags')
        raw = (path.parent / 'request.json').read_bytes()
        mutation = operation in ('contexts.publish', 'releases.open')
        if '--execute' not in flags:
            print(json.dumps(dict(operation=operation, preview=True, effect='write' if mutation else 'read', inputSha256=hashlib.sha256(raw).hexdigest(), requiredEnvironment=sorted(set(re.findall(r'AGENTTRUNK_[A-Z_]+', raw.decode()))))))
            return
        if mutation and '--yes' not in flags: raise ValueError('Write approval required')
        os.environ['AGENTTRUNK_ACCESS_TOKEN']
        client = AgentTrunk(access_token=lambda: os.environ['AGENTTRUNK_ACCESS_TOKEN'], base_url=os.getenv('AGENTTRUNK_API_URL', 'https://api.agenttrunk.ai'), max_retries=0)
        result = execute(client, substitute(json.loads(raw)))
        if hasattr(result, 'model_dump_json'): print(result.model_dump_json(by_alias=True))
        else: print(json.dumps(result))
    except Exception:
        print('Workflow failed. Check configuration and permissions; reconcile an uncertain write before retrying.', file=sys.stderr)
        sys.exit(1)
