# Publish a complete multi-file Agent Skill

This example packages a support-response skill and its escalation reference as two reviewed inline files. It never crawls a directory. Replace the sample with your explicitly approved files when adapting it; keep every file the package needs.

Required non-secret configuration: `AGENTTRUNK_WORKSPACE_ID`, `AGENTTRUNK_SCOPE_ID`, `AGENTTRUNK_CONTEXT_KEY`. Choose a new example key or intentionally replace an existing package. Preview needs no token:

```sh
node examples/publish-skill/index.mjs
```

The result includes the complete publication input and a replacement warning, with no network calls. Review it. When this exact staging write is authorized, supply the token through your runtime and opt in:

```sh
AGENTTRUNK_WRITE=1 node examples/publish-skill/index.mjs
```

That sends one publication, inspects the returned immutable revision, reads both files and verifies their bytes match the intended package. The receipt reports the revision/package digest and verified file count. It neither opens a release nor changes production. The sample does not send support messages.

Limits: 1–256 files, 1,000,000 bytes each, 16,000,000 decoded bytes total. A skill includes `SKILL.md` with valid name/description frontmatter and every referenced resource. Upload is a complete replacement, not a patch. If verification fails after upload, the staging write may already exist: [reconcile](../../docs/troubleshooting.md) rather than rerunning blindly.

Next: validate the skill's behavior in your own runtime and use [release review](../release-review/README.md). Source: [index.mjs](index.mjs).
