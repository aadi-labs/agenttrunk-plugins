"""Read-only generated SDK quickstart. Credentials come from the runtime environment."""
import os
from agenttrunk import AgentTrunk


def main():
    client = AgentTrunk(access_token=lambda: os.environ['AGENTTRUNK_ACCESS_TOKEN'])
    workspace = os.getenv('AGENTTRUNK_WORKSPACE_ID')
    cursor = None
    for _ in range(10):
        if workspace:
            page = client.contexts.discover(trunk_id=workspace, channel='production', cursor=cursor)
            for item in page.data:
                print(item.context_key, item.revision_id)
        else:
            page = client.workspaces.list(cursor=cursor)
            for item in page.data:
                print(item.id, item.name)
        cursor = page.next_cursor
        if not cursor:
            return
    print('Partial results: page budget reached. Resume with the next cursor in your runtime.')


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        # Do not dump headers, provider bodies, validation input or tokens.
        print('AgentTrunk request failed; check access, configuration and network.')
        raise SystemExit(1) from None
