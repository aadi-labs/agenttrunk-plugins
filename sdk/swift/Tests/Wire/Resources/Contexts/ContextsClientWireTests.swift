import Foundation
import Testing
import AgentTrunk

@Suite("ContextsClient Wire Tests") struct ContextsClientWireTests {
    @Test func export1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "key": "value"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "key": JSONValue.string("value")
        ]
        let response = try await client.contexts.export(
            trunkId: "trunkId",
            contextKey: "contextKey",
            revisionId: "revisionId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func export2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "string": {
                    "key": "value"
                  }
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "string": JSONValue.object(
                [
                    "key": JSONValue.string("value")
                ]
            )
        ]
        let response = try await client.contexts.export(
            trunkId: "trunkId",
            contextKey: "contextKey",
            revisionId: "revisionId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getRollbackPlan1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "eligible": true,
                  "expectedStagingRevisionId": "expectedStagingRevisionId",
                  "reason": "reason"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = GetRollbackPlanContextsResponse(
            eligible: true,
            expectedStagingRevisionId: Nullable<String>.value("expectedStagingRevisionId"),
            reason: "reason"
        )
        let response = try await client.contexts.getRollbackPlan(
            trunkId: "trunkId",
            contextKey: "contextKey",
            revisionId: "revisionId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getRollbackPlan2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "eligible": true,
                  "expectedStagingRevisionId": "expectedStagingRevisionId",
                  "reason": "reason"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = GetRollbackPlanContextsResponse(
            eligible: true,
            expectedStagingRevisionId: Nullable<String>.value("expectedStagingRevisionId"),
            reason: "reason"
        )
        let response = try await client.contexts.getRollbackPlan(
            trunkId: "trunkId",
            contextKey: "contextKey",
            revisionId: "revisionId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func stageRollback1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "key": "value"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "key": JSONValue.string("value")
        ]
        let response = try await client.contexts.stageRollback(
            trunkId: "trunkId",
            contextKey: "contextKey",
            request: .init(
                revisionId: "revisionId",
                expectedStagingRevisionId: "expectedStagingRevisionId",
                reason: "reason"
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func stageRollback2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "string": {
                    "key": "value"
                  }
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "string": JSONValue.object(
                [
                    "key": JSONValue.string("value")
                ]
            )
        ]
        let response = try await client.contexts.stageRollback(
            trunkId: "trunkId",
            contextKey: "contextKey",
            request: .init(
                revisionId: "revisionId",
                expectedStagingRevisionId: "expectedStagingRevisionId",
                reason: "x"
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func publish1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "context": {
                    "id": "id",
                    "trunkId": "trunkId",
                    "scopeId": "scopeId",
                    "key": "key",
                    "title": "title",
                    "kind": "skill",
                    "summary": "summary",
                    "tags": [
                      "tags"
                    ],
                    "createdAt": "2024-01-15T09:30:00Z",
                    "updatedAt": "2024-01-15T09:30:00Z"
                  },
                  "revision": {
                    "id": "id",
                    "contextId": "contextId",
                    "packageDigest": "packageDigest",
                    "parentRevisionId": "parentRevisionId",
                    "files": [
                      {
                        "path": "path",
                        "size": 1,
                        "sha256": "sha256"
                      }
                    ],
                    "createdAt": "2024-01-15T09:30:00Z"
                  }
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = PublishContextsResponse(
            context: Context(
                id: "id",
                trunkId: "trunkId",
                scopeId: "scopeId",
                key: "key",
                title: "title",
                kind: ContextKind.skill,
                summary: "summary",
                tags: [
                    "tags"
                ],
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
            ),
            revision: Revision(
                id: "id",
                contextId: "contextId",
                packageDigest: "packageDigest",
                parentRevisionId: Optional(Nullable<String>.value("parentRevisionId")),
                files: [
                    FileRecord(
                        path: "path",
                        size: 1,
                        sha256: "sha256"
                    )
                ],
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
            )
        )
        let response = try await client.contexts.publish(
            trunkId: "trunkId",
            request: .init(
                contextKey: "contextKey",
                title: "title",
                kind: .skill,
                files: [
                    FileInput(
                        path: "path",
                        contentBase64: "contentBase64"
                    )
                ]
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func publish2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "context": {
                    "id": "id",
                    "trunkId": "trunkId",
                    "scopeId": "scopeId",
                    "key": "key",
                    "title": "title",
                    "kind": "skill",
                    "summary": "summary",
                    "tags": [
                      "tags",
                      "tags"
                    ],
                    "createdAt": "2024-01-15T09:30:00Z",
                    "updatedAt": "2024-01-15T09:30:00Z"
                  },
                  "revision": {
                    "id": "id",
                    "contextId": "contextId",
                    "packageDigest": "packageDigest",
                    "parentRevisionId": "parentRevisionId",
                    "files": [
                      {
                        "path": "path",
                        "size": 1000000,
                        "sha256": "sha256"
                      },
                      {
                        "path": "path",
                        "size": 1000000,
                        "sha256": "sha256"
                      }
                    ],
                    "createdAt": "2024-01-15T09:30:00Z"
                  }
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = PublishContextsResponse(
            context: Context(
                id: "id",
                trunkId: "trunkId",
                scopeId: "scopeId",
                key: "key",
                title: "title",
                kind: ContextKind.skill,
                summary: "summary",
                tags: [
                    "tags",
                    "tags"
                ],
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
            ),
            revision: Revision(
                id: "id",
                contextId: "contextId",
                packageDigest: "packageDigest",
                parentRevisionId: Optional(Nullable<String>.value("parentRevisionId")),
                files: [
                    FileRecord(
                        path: "path",
                        size: 1000000,
                        sha256: "sha256"
                    ),
                    FileRecord(
                        path: "path",
                        size: 1000000,
                        sha256: "sha256"
                    )
                ],
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
            )
        )
        let response = try await client.contexts.publish(
            trunkId: "trunkId",
            request: .init(
                contextKey: "contextKey",
                title: "title",
                kind: .skill,
                files: [
                    FileInput(
                        path: "x",
                        contentBase64: "contentBase64"
                    ),
                    FileInput(
                        path: "x",
                        contentBase64: "contentBase64"
                    )
                ]
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func share1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "key": "value"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "key": JSONValue.string("value")
        ]
        let response = try await client.contexts.share(
            trunkId: "trunkId",
            contextKey: "contextKey",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func share2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "string": {
                    "key": "value"
                  }
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "string": JSONValue.object(
                [
                    "key": JSONValue.string("value")
                ]
            )
        ]
        let response = try await client.contexts.share(
            trunkId: "trunkId",
            contextKey: "contextKey",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func discover1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "data": [
                    {
                      "trunkId": "trunkId",
                      "scopeId": "scopeId",
                      "contextKey": "contextKey",
                      "title": "title",
                      "kind": "skill",
                      "summary": "summary",
                      "tags": [
                        "tags"
                      ],
                      "revisionId": "revisionId",
                      "packageDigest": "packageDigest",
                      "channel": "production",
                      "updatedAt": "2024-01-15T09:30:00Z"
                    }
                  ],
                  "nextCursor": "nextCursor"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = DiscoverContextsResponse(
            data: [
                DiscoveryResult(
                    trunkId: "trunkId",
                    scopeId: "scopeId",
                    contextKey: "contextKey",
                    title: "title",
                    kind: ContextKind.skill,
                    summary: "summary",
                    tags: [
                        "tags"
                    ],
                    revisionId: "revisionId",
                    packageDigest: "packageDigest",
                    channel: DiscoveryResultChannel.production,
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
                )
            ],
            nextCursor: Optional(Nullable<String>.value("nextCursor"))
        )
        let response = try await client.contexts.discover(requestOptions: RequestOptions(additionalHeaders: stub.headers))
        try #require(response == expectedResponse)
    }

    @Test func discover2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "data": [
                    {
                      "trunkId": "trunkId",
                      "scopeId": "scopeId",
                      "contextKey": "contextKey",
                      "title": "title",
                      "kind": "skill",
                      "summary": "summary",
                      "tags": [
                        "tags",
                        "tags"
                      ],
                      "revisionId": "revisionId",
                      "packageDigest": "packageDigest",
                      "channel": "production",
                      "updatedAt": "2024-01-15T09:30:00Z"
                    },
                    {
                      "trunkId": "trunkId",
                      "scopeId": "scopeId",
                      "contextKey": "contextKey",
                      "title": "title",
                      "kind": "skill",
                      "summary": "summary",
                      "tags": [
                        "tags",
                        "tags"
                      ],
                      "revisionId": "revisionId",
                      "packageDigest": "packageDigest",
                      "channel": "production",
                      "updatedAt": "2024-01-15T09:30:00Z"
                    }
                  ],
                  "nextCursor": "nextCursor"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = DiscoverContextsResponse(
            data: [
                DiscoveryResult(
                    trunkId: "trunkId",
                    scopeId: "scopeId",
                    contextKey: "contextKey",
                    title: "title",
                    kind: ContextKind.skill,
                    summary: "summary",
                    tags: [
                        "tags",
                        "tags"
                    ],
                    revisionId: "revisionId",
                    packageDigest: "packageDigest",
                    channel: DiscoveryResultChannel.production,
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
                ),
                DiscoveryResult(
                    trunkId: "trunkId",
                    scopeId: "scopeId",
                    contextKey: "contextKey",
                    title: "title",
                    kind: ContextKind.skill,
                    summary: "summary",
                    tags: [
                        "tags",
                        "tags"
                    ],
                    revisionId: "revisionId",
                    packageDigest: "packageDigest",
                    channel: DiscoveryResultChannel.production,
                    updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
                )
            ],
            nextCursor: Optional(Nullable<String>.value("nextCursor"))
        )
        let response = try await client.contexts.discover(requestOptions: RequestOptions(additionalHeaders: stub.headers))
        try #require(response == expectedResponse)
    }

    @Test func inspect1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "context": {
                    "id": "id",
                    "trunkId": "trunkId",
                    "scopeId": "scopeId",
                    "key": "key",
                    "title": "title",
                    "kind": "skill",
                    "summary": "summary",
                    "tags": [
                      "tags"
                    ],
                    "createdAt": "2024-01-15T09:30:00Z",
                    "updatedAt": "2024-01-15T09:30:00Z"
                  },
                  "revision": {
                    "id": "id",
                    "contextId": "contextId",
                    "packageDigest": "packageDigest",
                    "parentRevisionId": "parentRevisionId",
                    "files": [
                      {
                        "path": "path",
                        "size": 1,
                        "sha256": "sha256"
                      }
                    ],
                    "createdAt": "2024-01-15T09:30:00Z"
                  }
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = InspectContextsResponse(
            context: Context(
                id: "id",
                trunkId: "trunkId",
                scopeId: "scopeId",
                key: "key",
                title: "title",
                kind: ContextKind.skill,
                summary: "summary",
                tags: [
                    "tags"
                ],
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
            ),
            revision: Revision(
                id: "id",
                contextId: "contextId",
                packageDigest: "packageDigest",
                parentRevisionId: Optional(Nullable<String>.value("parentRevisionId")),
                files: [
                    FileRecord(
                        path: "path",
                        size: 1,
                        sha256: "sha256"
                    )
                ],
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
            )
        )
        let response = try await client.contexts.inspect(
            trunkId: "trunkId",
            contextKey: "contextKey",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func inspect2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "context": {
                    "id": "id",
                    "trunkId": "trunkId",
                    "scopeId": "scopeId",
                    "key": "key",
                    "title": "title",
                    "kind": "skill",
                    "summary": "summary",
                    "tags": [
                      "tags",
                      "tags"
                    ],
                    "createdAt": "2024-01-15T09:30:00Z",
                    "updatedAt": "2024-01-15T09:30:00Z"
                  },
                  "revision": {
                    "id": "id",
                    "contextId": "contextId",
                    "packageDigest": "packageDigest",
                    "parentRevisionId": "parentRevisionId",
                    "files": [
                      {
                        "path": "path",
                        "size": 1000000,
                        "sha256": "sha256"
                      },
                      {
                        "path": "path",
                        "size": 1000000,
                        "sha256": "sha256"
                      }
                    ],
                    "createdAt": "2024-01-15T09:30:00Z"
                  }
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = InspectContextsResponse(
            context: Context(
                id: "id",
                trunkId: "trunkId",
                scopeId: "scopeId",
                key: "key",
                title: "title",
                kind: ContextKind.skill,
                summary: "summary",
                tags: [
                    "tags",
                    "tags"
                ],
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                updatedAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
            ),
            revision: Revision(
                id: "id",
                contextId: "contextId",
                packageDigest: "packageDigest",
                parentRevisionId: Optional(Nullable<String>.value("parentRevisionId")),
                files: [
                    FileRecord(
                        path: "path",
                        size: 1000000,
                        sha256: "sha256"
                    ),
                    FileRecord(
                        path: "path",
                        size: 1000000,
                        sha256: "sha256"
                    )
                ],
                createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
            )
        )
        let response = try await client.contexts.inspect(
            trunkId: "trunkId",
            contextKey: "contextKey",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func history1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "data": [
                    {
                      "id": "id",
                      "contextId": "contextId",
                      "packageDigest": "packageDigest",
                      "parentRevisionId": "parentRevisionId",
                      "files": [
                        {
                          "path": "path",
                          "size": 1,
                          "sha256": "sha256"
                        }
                      ],
                      "createdAt": "2024-01-15T09:30:00Z"
                    }
                  ],
                  "next": "next"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = HistoryContextsResponse(
            data: [
                Revision(
                    id: "id",
                    contextId: "contextId",
                    packageDigest: "packageDigest",
                    parentRevisionId: Optional(Nullable<String>.value("parentRevisionId")),
                    files: [
                        FileRecord(
                            path: "path",
                            size: 1,
                            sha256: "sha256"
                        )
                    ],
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
                )
            ],
            next: Optional(Nullable<String>.value("next"))
        )
        let response = try await client.contexts.history(
            trunkId: "trunkId",
            contextKey: "contextKey",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func history2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "data": [
                    {
                      "id": "id",
                      "contextId": "contextId",
                      "packageDigest": "packageDigest",
                      "parentRevisionId": "parentRevisionId",
                      "files": [
                        {
                          "path": "path",
                          "size": 1000000,
                          "sha256": "sha256"
                        },
                        {
                          "path": "path",
                          "size": 1000000,
                          "sha256": "sha256"
                        }
                      ],
                      "createdAt": "2024-01-15T09:30:00Z"
                    },
                    {
                      "id": "id",
                      "contextId": "contextId",
                      "packageDigest": "packageDigest",
                      "parentRevisionId": "parentRevisionId",
                      "files": [
                        {
                          "path": "path",
                          "size": 1000000,
                          "sha256": "sha256"
                        },
                        {
                          "path": "path",
                          "size": 1000000,
                          "sha256": "sha256"
                        }
                      ],
                      "createdAt": "2024-01-15T09:30:00Z"
                    }
                  ],
                  "next": "next"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = HistoryContextsResponse(
            data: [
                Revision(
                    id: "id",
                    contextId: "contextId",
                    packageDigest: "packageDigest",
                    parentRevisionId: Optional(Nullable<String>.value("parentRevisionId")),
                    files: [
                        FileRecord(
                            path: "path",
                            size: 1000000,
                            sha256: "sha256"
                        ),
                        FileRecord(
                            path: "path",
                            size: 1000000,
                            sha256: "sha256"
                        )
                    ],
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
                ),
                Revision(
                    id: "id",
                    contextId: "contextId",
                    packageDigest: "packageDigest",
                    parentRevisionId: Optional(Nullable<String>.value("parentRevisionId")),
                    files: [
                        FileRecord(
                            path: "path",
                            size: 1000000,
                            sha256: "sha256"
                        ),
                        FileRecord(
                            path: "path",
                            size: 1000000,
                            sha256: "sha256"
                        )
                    ],
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
                )
            ],
            next: Optional(Nullable<String>.value("next"))
        )
        let response = try await client.contexts.history(
            trunkId: "trunkId",
            contextKey: "contextKey",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func compare1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "key": "value"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "key": JSONValue.string("value")
        ]
        let response = try await client.contexts.compare(
            trunkId: "trunkId",
            contextKey: "contextKey",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func compare2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "string": {
                    "key": "value"
                  }
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "string": JSONValue.object(
                [
                    "key": JSONValue.string("value")
                ]
            )
        ]
        let response = try await client.contexts.compare(
            trunkId: "trunkId",
            contextKey: "contextKey",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getProvenance1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "key": "value"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "key": JSONValue.string("value")
        ]
        let response = try await client.contexts.getProvenance(
            trunkId: "trunkId",
            contextKey: "contextKey",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func getProvenance2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "string": {
                    "key": "value"
                  }
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "string": JSONValue.object(
                [
                    "key": JSONValue.string("value")
                ]
            )
        ]
        let response = try await client.contexts.getProvenance(
            trunkId: "trunkId",
            contextKey: "contextKey",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func putProvenance1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "key": "value"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "key": JSONValue.string("value")
        ]
        let response = try await client.contexts.putProvenance(
            trunkId: "trunkId",
            contextKey: "contextKey",
            request: .init(
                revisionId: "revisionId",
                text: "text",
                expectedNotesCommitSha: .null
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func putProvenance2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "string": {
                    "key": "value"
                  }
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = [
            "string": JSONValue.object(
                [
                    "key": JSONValue.string("value")
                ]
            )
        ]
        let response = try await client.contexts.putProvenance(
            trunkId: "trunkId",
            contextKey: "contextKey",
            request: .init(
                revisionId: "revisionId",
                text: "x",
                expectedNotesCommitSha: .null
            ),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}