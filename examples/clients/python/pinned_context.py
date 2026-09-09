"""Load one verified file from an explicitly selected immutable revision."""
import os
import sys
from agenttrunk import AgentTrunk
from agenttrunk.verified import read_verified_file

def main():
    client = AgentTrunk(access_token=lambda: os.environ['AGENTTRUNK_ACCESS_TOKEN'], base_url=os.getenv('AGENTTRUNK_API_URL','https://api.agenttrunk.ai'))
    data = read_verified_file(client, os.environ['AGENTTRUNK_WORKSPACE_ID'], os.environ['AGENTTRUNK_CONTEXT_KEY'], os.environ['AGENTTRUNK_REVISION_ID'], os.environ['AGENTTRUNK_RESOURCE_PATH'])
    sys.stdout.buffer.write(data)

if __name__ == '__main__':
    try: main()
    except Exception:
        print('Verified read failed. Check the pin, path, permissions and runtime token.', file=sys.stderr)
        sys.exit(1)
