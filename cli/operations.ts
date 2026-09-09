// Generated from reviewed OpenAPI and Fern signatures by scripts/generate-cli.mjs.
export const operations = [
  {
    "name": "billing.createCheckout",
    "group": "billing",
    "method": "createCheckout",
    "verb": "POST",
    "path": "/v1/billing/checkout",
    "summary": "Requires billing:manage. Reuses an unexpired checkout; existing subscriptions must use the portal. Body limited to 4096 bytes.",
    "parameters": [
      {
        "name": "request",
        "required": true
      }
    ],
    "requestSchema": {
      "type": "object",
      "required": [
        "plan"
      ],
      "properties": {
        "plan": {
          "type": "string",
          "enum": [
            "starter",
            "startup",
            "scale"
          ]
        }
      }
    },
    "query": []
  },
  {
    "name": "billing.createPortal",
    "group": "billing",
    "method": "createPortal",
    "verb": "POST",
    "path": "/v1/billing/portal",
    "summary": "Requires billing:manage and an existing organization customer.",
    "parameters": [],
    "query": []
  },
  {
    "name": "billing.get",
    "group": "billing",
    "method": "get",
    "verb": "GET",
    "path": "/v1/billing",
    "summary": "Organization subscription and usage summary. Requires billing:read. MCP metering is currently inactive.",
    "parameters": [],
    "query": []
  },
  {
    "name": "billing.setSpendLimit",
    "group": "billing",
    "method": "setSpendLimit",
    "verb": "POST",
    "path": "/v1/billing/spend-limit",
    "summary": "Requires billing:manage. Audited organization overage cap; excludes subscription fees and taxes. Does not activate metering.",
    "parameters": [
      {
        "name": "request",
        "required": true
      }
    ],
    "requestSchema": {
      "type": "object",
      "required": [
        "cents"
      ],
      "properties": {
        "cents": {
          "type": "integer",
          "minimum": 0,
          "maximum": 1000000
        }
      }
    },
    "query": []
  },
  {
    "name": "contexts.compare",
    "group": "contexts",
    "method": "compare",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/contexts/{contextKey}/compare",
    "summary": "Authorizes both revisions and returns their manifests, per-file statuses,\nand one selected file preview. Target defaults to latest; base defaults to\nthe target's parent, or an empty snapshot for the first revision. The\nreturned IDs are immutable; use them for subsequent file selections.\nUTF-8 previews verify file digests and are capped at 128000 bytes per side.\nreason is null, too_large, binary, or too_complex. Omitted previews have\nempty content and zero counts, which must not be displayed as no changes.\n",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "contextKey",
        "required": true
      },
      {
        "name": "request",
        "required": false
      }
    ],
    "query": [
      {
        "name": "base",
        "in": "query",
        "schema": {
          "type": "string",
          "maxLength": 128
        }
      },
      {
        "name": "target",
        "in": "query",
        "schema": {
          "type": "string",
          "maxLength": 128,
          "default": "latest"
        }
      },
      {
        "name": "path",
        "in": "query",
        "schema": {
          "type": "string",
          "maxLength": 512
        }
      }
    ]
  },
  {
    "name": "contexts.discover",
    "group": "contexts",
    "method": "discover",
    "verb": "GET",
    "path": "/v1/contexts",
    "summary": "",
    "parameters": [
      {
        "name": "request",
        "required": false
      }
    ],
    "query": [
      {
        "name": "scopeId",
        "in": "query",
        "description": "Filter by scope before applying the result limit.",
        "schema": {
          "type": "string"
        }
      },
      {
        "name": "cursor",
        "in": "query",
        "description": "Opaque snapshot continuation returned by the preceding page. Keep filters and principal unchanged; cursors expire after 15 minutes. Authorization is always rechecked. Restart pagination for expired or legacy numeric cursors.",
        "schema": {
          "type": "string",
          "maxLength": 43
        }
      },
      {
        "name": "trunkId",
        "in": "query",
        "description": "Narrow discovery to this authorized trunk before applying the result limit.",
        "schema": {
          "type": "string"
        }
      },
      {
        "name": "query",
        "in": "query",
        "schema": {
          "type": "string",
          "maxLength": 200,
          "default": ""
        }
      },
      {
        "name": "channel",
        "in": "query",
        "schema": {
          "type": "string",
          "enum": [
            "production",
            "staging",
            "latest"
          ],
          "default": "production"
        }
      },
      {
        "name": "limit",
        "in": "query",
        "schema": {
          "type": "integer",
          "minimum": 1,
          "maximum": 20,
          "default": 20
        }
      }
    ]
  },
  {
    "name": "contexts.export",
    "group": "contexts",
    "method": "export",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/contexts/{contextKey}/export",
    "summary": "Export a pinned context revision",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "contextKey",
        "required": true
      },
      {
        "name": "request",
        "required": true
      }
    ],
    "query": []
  },
  {
    "name": "contexts.getProvenance",
    "group": "contexts",
    "method": "getProvenance",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/contexts/{contextKey}/provenance",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "contextKey",
        "required": true
      },
      {
        "name": "request",
        "required": false
      }
    ],
    "query": [
      {
        "name": "ref",
        "in": "query",
        "schema": {
          "type": "string",
          "default": "latest"
        }
      }
    ]
  },
  {
    "name": "contexts.getRollbackPlan",
    "group": "contexts",
    "method": "getRollbackPlan",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/contexts/{contextKey}/rollback",
    "summary": "Check whether an immutable revision can be restored to staging. This is advisory; the write rechecks permissions, release evidence, and staging concurrency. Ineligible responses do not expose the current staging revision.",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "contextKey",
        "required": true
      },
      {
        "name": "request",
        "required": true
      }
    ],
    "query": [
      {
        "name": "revisionId",
        "in": "query",
        "required": true,
        "schema": {
          "type": "string",
          "pattern": "^[a-f0-9]{64}$"
        }
      }
    ]
  },
  {
    "name": "contexts.history",
    "group": "contexts",
    "method": "history",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/contexts/{contextKey}/history",
    "summary": "Follows immutable parent revisions, authorizing every revision. Historic IDs require staging read or shared-context-item read access.",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "contextKey",
        "required": true
      },
      {
        "name": "request",
        "required": false
      }
    ],
    "query": [
      {
        "name": "from",
        "in": "query",
        "schema": {
          "type": "string",
          "default": "latest"
        }
      },
      {
        "name": "limit",
        "in": "query",
        "schema": {
          "type": "integer",
          "minimum": 1,
          "maximum": 50,
          "default": 50
        }
      }
    ]
  },
  {
    "name": "contexts.inspect",
    "group": "contexts",
    "method": "inspect",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/contexts/{contextKey}",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "contextKey",
        "required": true
      },
      {
        "name": "request",
        "required": false
      }
    ],
    "query": []
  },
  {
    "name": "contexts.publish",
    "group": "contexts",
    "method": "publish",
    "verb": "POST",
    "path": "/v1/trunks/{trunkId}/publications",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "request",
        "required": true
      }
    ],
    "requestSchema": {
      "$ref": "#/components/schemas/PublishInput"
    },
    "query": []
  },
  {
    "name": "contexts.putProvenance",
    "group": "contexts",
    "method": "putProvenance",
    "verb": "PUT",
    "path": "/v1/trunks/{trunkId}/contexts/{contextKey}/provenance",
    "summary": "Requires revision read and staging environment deployment permission. Author identity is assigned server-side. Does not modify content, channels, or PR approval. Concurrent updates return 409; reread and reconcile, never blindly retry with a newer token.",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "contextKey",
        "required": true
      },
      {
        "name": "request",
        "required": true
      }
    ],
    "requestSchema": {
      "type": "object",
      "required": [
        "revisionId",
        "text",
        "expectedNotesCommitSha"
      ],
      "properties": {
        "revisionId": {
          "type": "string",
          "pattern": "^[a-f0-9]{64}$"
        },
        "text": {
          "type": "string",
          "minLength": 1,
          "maxLength": 16000,
          "description": "Maximum 16000 UTF-8 bytes; not 16000 arbitrary Unicode characters."
        },
        "expectedNotesCommitSha": {
          "type": [
            "string",
            "null"
          ],
          "pattern": "^[a-f0-9]{40}$",
          "description": "Null for the first note; otherwise the notesCommitSha returned by GET."
        }
      }
    },
    "query": []
  },
  {
    "name": "contexts.readFile",
    "group": "contexts",
    "method": "readFile",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/contexts/{contextKey}/files/{resourcePath}",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "contextKey",
        "required": true
      },
      {
        "name": "resourcePath",
        "required": true
      },
      {
        "name": "request",
        "required": true
      }
    ],
    "query": [
      {
        "name": "ref",
        "in": "query",
        "required": true,
        "description": "Immutable revision ID from inspect; resolve moving channels before reading.",
        "schema": {
          "type": "string",
          "pattern": "^[a-f0-9]{64}$"
        }
      }
    ]
  },
  {
    "name": "contexts.share",
    "group": "contexts",
    "method": "share",
    "verb": "POST",
    "path": "/v1/trunks/{trunkId}/contexts/{contextKey}/share",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "contextKey",
        "required": true
      }
    ],
    "query": []
  },
  {
    "name": "contexts.stageRollback",
    "group": "contexts",
    "method": "stageRollback",
    "verb": "POST",
    "path": "/v1/trunks/{trunkId}/contexts/{contextKey}/rollback",
    "summary": "Restore a previously released immutable revision into staging. Requires production rollback and staging deploy permissions. Production only changes through a subsequent promotion PR.",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "contextKey",
        "required": true
      },
      {
        "name": "request",
        "required": true
      }
    ],
    "requestSchema": {
      "type": "object",
      "required": [
        "revisionId",
        "expectedStagingRevisionId",
        "reason"
      ],
      "properties": {
        "revisionId": {
          "type": "string",
          "pattern": "^[a-f0-9]{64}$"
        },
        "expectedStagingRevisionId": {
          "type": "string",
          "pattern": "^[a-f0-9]{64}$"
        },
        "reason": {
          "type": "string",
          "minLength": 1,
          "maxLength": 500
        }
      }
    },
    "query": []
  },
  {
    "name": "contextSets.create",
    "group": "contextSets",
    "method": "create",
    "verb": "POST",
    "path": "/v1/context-sets",
    "summary": "",
    "parameters": [
      {
        "name": "request",
        "required": true
      }
    ],
    "requestSchema": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "name",
        "sources"
      ],
      "properties": {
        "name": {
          "type": "string",
          "minLength": 1,
          "maxLength": 200
        },
        "sources": {
          "type": "array",
          "minItems": 1,
          "maxItems": 64,
          "items": {
            "$ref": "#/components/schemas/ContextSetSource"
          }
        }
      }
    },
    "query": []
  },
  {
    "name": "contextSets.list",
    "group": "contextSets",
    "method": "list",
    "verb": "GET",
    "path": "/v1/context-sets",
    "summary": "Snapshot-stable candidates with current WorkOS authorization rechecked on each page. Cursors expire after 15 minutes and are bound to the principal and filters.",
    "parameters": [
      {
        "name": "request",
        "required": false
      }
    ],
    "query": [
      {
        "name": "cursor",
        "in": "query",
        "schema": {
          "type": "string",
          "maxLength": 43
        }
      },
      {
        "name": "limit",
        "in": "query",
        "schema": {
          "type": "integer",
          "minimum": 1,
          "maximum": 100,
          "default": 100
        }
      }
    ]
  },
  {
    "name": "contextSets.resolve",
    "group": "contextSets",
    "method": "resolve",
    "verb": "POST",
    "path": "/v1/context-sets/{contextSetId}/resolve",
    "summary": "",
    "parameters": [
      {
        "name": "contextSetId",
        "required": true
      }
    ],
    "query": []
  },
  {
    "name": "contextSets.sources",
    "group": "contextSets",
    "method": "sources",
    "verb": "GET",
    "path": "/v1/context-sources",
    "summary": "Returns up to 20 candidates with current authorization checks and an opaque nextCursor. Snapshots expire after 15 minutes; narrow the scope if the 10000-record or 8 MB snapshot limit is exceeded.",
    "parameters": [
      {
        "name": "request",
        "required": false
      }
    ],
    "query": [
      {
        "name": "cursor",
        "in": "query",
        "schema": {
          "type": "string",
          "maxLength": 43
        }
      }
    ]
  },
  {
    "name": "health.get",
    "group": "health",
    "method": "get",
    "verb": "GET",
    "path": "/healthz",
    "summary": "",
    "parameters": [],
    "query": []
  },
  {
    "name": "privacy.assignReview",
    "group": "privacy",
    "method": "assignReview",
    "verb": "POST",
    "path": "/v1/trunks/{trunkId}/privacy-requests/{requestId}/review",
    "summary": "Assign privacy review to the authorizing user",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "requestId",
        "required": true
      },
      {
        "name": "request",
        "required": true
      }
    ],
    "requestSchema": {
      "type": "object",
      "additionalProperties": false
    },
    "query": []
  },
  {
    "name": "privacy.create",
    "group": "privacy",
    "method": "create",
    "verb": "POST",
    "path": "/v1/trunks/{trunkId}/privacy-requests",
    "summary": "Record a manual access or erasure review request",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "request",
        "required": true
      }
    ],
    "requestSchema": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "kind"
      ],
      "properties": {
        "kind": {
          "type": "string",
          "enum": [
            "access",
            "erasure"
          ]
        }
      }
    },
    "query": []
  },
  {
    "name": "privacy.erasurePlan",
    "group": "privacy",
    "method": "erasurePlan",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/erasure-plan",
    "summary": "Read-only workspace erasure inventory",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      }
    ],
    "query": []
  },
  {
    "name": "privacy.list",
    "group": "privacy",
    "method": "list",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/privacy-requests",
    "summary": "List the latest 20 workspace privacy review requests",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      }
    ],
    "query": []
  },
  {
    "name": "releases.list",
    "group": "releases",
    "method": "list",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/promotion-requests",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "request",
        "required": false
      }
    ],
    "query": [
      {
        "name": "cursor",
        "in": "query",
        "schema": {
          "type": "string"
        }
      },
      {
        "name": "scopeId",
        "in": "query",
        "schema": {
          "type": "string",
          "maxLength": 200
        }
      },
      {
        "name": "status",
        "in": "query",
        "schema": {
          "type": "string",
          "enum": [
            "open",
            "merged",
            "closed"
          ]
        }
      },
      {
        "name": "limit",
        "in": "query",
        "schema": {
          "type": "integer",
          "minimum": 1,
          "maximum": 100,
          "default": 50
        }
      }
    ]
  },
  {
    "name": "releases.merge",
    "group": "releases",
    "method": "merge",
    "verb": "POST",
    "path": "/v1/trunks/{trunkId}/promotion-requests/{promotionId}/merge",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "promotionId",
        "required": true
      }
    ],
    "query": []
  },
  {
    "name": "releases.open",
    "group": "releases",
    "method": "open",
    "verb": "POST",
    "path": "/v1/trunks/{trunkId}/promotion-requests",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "request",
        "required": false
      }
    ],
    "requestSchema": {
      "$ref": "#/components/schemas/OpenPromotionRequestInput"
    },
    "query": []
  },
  {
    "name": "scopes.create",
    "group": "scopes",
    "method": "create",
    "verb": "POST",
    "path": "/v1/trunks/{trunkId}/scopes",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "request",
        "required": true
      }
    ],
    "requestSchema": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "name"
      ],
      "properties": {
        "name": {
          "type": "string",
          "minLength": 1,
          "maxLength": 200
        },
        "slug": {
          "type": "string",
          "maxLength": 80
        }
      }
    },
    "query": []
  },
  {
    "name": "scopes.list",
    "group": "scopes",
    "method": "list",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/scopes",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      }
    ],
    "query": []
  },
  {
    "name": "webhooks.createPortal",
    "group": "webhooks",
    "method": "createPortal",
    "verb": "POST",
    "path": "/v1/trunks/{trunkId}/webhooks/portal",
    "summary": "Requires trunk management permission. Enables future workspace events and returns a one-hour bearer access URL for endpoint configuration, delivery inspection, and replay. Never cache or log the URL. Previously issued links remain valid until expiry.",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      }
    ],
    "query": []
  },
  {
    "name": "webhooks.list",
    "group": "webhooks",
    "method": "list",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/webhooks",
    "summary": "Requires trunk management permission. Lists at most 50 workspace submission receipts, not endpoint delivery receipts. Pass nextCursor as before until null.",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "request",
        "required": false
      }
    ],
    "query": [
      {
        "name": "before",
        "in": "query",
        "schema": {
          "type": "string",
          "pattern": "^[1-9][0-9]{0,18}$"
        }
      }
    ]
  },
  {
    "name": "webhooks.retry",
    "group": "webhooks",
    "method": "retry",
    "verb": "POST",
    "path": "/v1/trunks/{trunkId}/webhooks/{eventId}/retry",
    "summary": "Requires trunk management permission. Requeue a failed provider submission with the same event identity. Accepted messages must be replayed through the Svix portal. Consumers must deduplicate events.",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "eventId",
        "required": true
      }
    ],
    "query": []
  },
  {
    "name": "workspaces.audit",
    "group": "workspaces",
    "method": "audit",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}/audit",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      },
      {
        "name": "request",
        "required": false
      }
    ],
    "query": [
      {
        "name": "limit",
        "in": "query",
        "schema": {
          "type": "integer",
          "minimum": 1,
          "maximum": 200,
          "default": 50
        }
      }
    ]
  },
  {
    "name": "workspaces.create",
    "group": "workspaces",
    "method": "create",
    "verb": "POST",
    "path": "/v1/trunks",
    "summary": "",
    "parameters": [
      {
        "name": "request",
        "required": true
      }
    ],
    "requestSchema": {
      "$ref": "#/components/schemas/CreateTrunkInput"
    },
    "query": []
  },
  {
    "name": "workspaces.get",
    "group": "workspaces",
    "method": "get",
    "verb": "GET",
    "path": "/v1/trunks/{trunkId}",
    "summary": "",
    "parameters": [
      {
        "name": "trunkId",
        "required": true
      }
    ],
    "query": []
  },
  {
    "name": "workspaces.list",
    "group": "workspaces",
    "method": "list",
    "verb": "GET",
    "path": "/v1/trunks",
    "summary": "",
    "parameters": [
      {
        "name": "request",
        "required": false
      }
    ],
    "query": [
      {
        "name": "cursor",
        "in": "query",
        "schema": {
          "type": "string"
        }
      },
      {
        "name": "q",
        "in": "query",
        "schema": {
          "type": "string",
          "maxLength": 200
        }
      },
      {
        "name": "limit",
        "in": "query",
        "schema": {
          "type": "integer",
          "minimum": 1,
          "maximum": 100,
          "default": 100
        }
      }
    ]
  }
] as const;
