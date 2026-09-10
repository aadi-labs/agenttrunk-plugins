# AgentTrunk workflow cookbook

Every recipe has a reviewed JSON input, a TypeScript/JavaScript runner and a Python runner. Both call generated SDK methods and preview without credentials. `--execute` enables reads; writes additionally require `--yes`. Set only the environment variables requested by the selected recipe. The runtime supplies `AGENTTRUNK_ACCESS_TOKEN`; never put it in a request file.

- [edit-context](edit-context/README.md)
- [workspace-audit](workspace-audit/README.md)
- [context-history](context-history/README.md)
- [context-compare](context-compare/README.md)
- [rollback-plan](rollback-plan/README.md)
- [context-export](context-export/README.md)
- [context-sets](context-sets/README.md)
- [context-sources](context-sources/README.md)
- [provenance](provenance/README.md)
- [webhook-deliveries](webhook-deliveries/README.md)
- [billing-status](billing-status/README.md)
- [privacy-requests](privacy-requests/README.md)
- [release-review](release-review/README.md)
- [publish-package](publish-package/README.md)
- [open-release](open-release/README.md)

For verified pinned reads use [pinned context](../pinned-context/README.md) and the [language examples](../clients/README.md). Go has executable publish and release examples inside its module.
