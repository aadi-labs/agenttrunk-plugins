import { definePluginEntry } from "openclaw/plugin-sdk/plugin-entry";
export default definePluginEntry({
  id: "agenttrunk", name: "AgentTrunk",
  description: "Discover, verify, stage and release versioned context for AI agents.",
  register() { /* The native manifest registers the shared skill. */ },
});
