import Foundation
import Testing
import AgentTrunk

@Suite("ReleasesClient Wire Tests") struct ReleasesClientWireTests {
    @Test func list1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "data": [
                    {
                      "id": "id",
                      "trunkId": "trunkId",
                      "scopeId": "scopeId",
                      "sourceCommitSha": "sourceCommitSha",
                      "targetCommitSha": "targetCommitSha",
                      "changes": [
                        {
                          "contextId": "contextId",
                          "contextKey": "contextKey",
                          "sourceRevisionId": "sourceRevisionId",
                          "targetRevisionId": null
                        }
                      ],
                      "status": "open",
                      "evidenceReference": "evidenceReference",
                      "createdBy": "createdBy",
                      "delegatedActorId": "delegatedActorId",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "mergedBy": "mergedBy",
                      "mergedDelegatedActorId": "mergedDelegatedActorId",
                      "mergedAt": "2024-01-15T09:30:00Z"
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
        let expectedResponse = ListReleasesResponse(
            data: [
                PromotionRequest(
                    id: "id",
                    trunkId: "trunkId",
                    scopeId: "scopeId",
                    sourceCommitSha: "sourceCommitSha",
                    targetCommitSha: Nullable<String>.value("targetCommitSha"),
                    changes: [
                        PromotionRequestChangesItem(
                            contextId: "contextId",
                            contextKey: "contextKey",
                            sourceRevisionId: "sourceRevisionId",
                            targetRevisionId: .null
                        )
                    ],
                    status: PromotionRequestStatus.open,
                    evidenceReference: Optional(Nullable<String>.value("evidenceReference")),
                    createdBy: "createdBy",
                    delegatedActorId: Optional(Nullable<String>.value("delegatedActorId")),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    mergedBy: Optional(Nullable<String>.value("mergedBy")),
                    mergedDelegatedActorId: Optional(Nullable<String>.value("mergedDelegatedActorId")),
                    mergedAt: Optional(Nullable<Date>.value(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)))
                )
            ],
            nextCursor: Optional(Nullable<String>.value("nextCursor"))
        )
        let response = try await client.releases.list(
            trunkId: "trunkId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func list2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "data": [
                    {
                      "id": "id",
                      "trunkId": "trunkId",
                      "scopeId": "scopeId",
                      "sourceCommitSha": "sourceCommitSha",
                      "targetCommitSha": "targetCommitSha",
                      "changes": [
                        {
                          "contextId": "contextId",
                          "contextKey": "contextKey",
                          "sourceRevisionId": "sourceRevisionId",
                          "targetRevisionId": "targetRevisionId"
                        },
                        {
                          "contextId": "contextId",
                          "contextKey": "contextKey",
                          "sourceRevisionId": "sourceRevisionId",
                          "targetRevisionId": "targetRevisionId"
                        }
                      ],
                      "status": "open",
                      "evidenceReference": "evidenceReference",
                      "createdBy": "createdBy",
                      "delegatedActorId": "delegatedActorId",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "mergedBy": "mergedBy",
                      "mergedDelegatedActorId": "mergedDelegatedActorId",
                      "mergedAt": "2024-01-15T09:30:00Z"
                    },
                    {
                      "id": "id",
                      "trunkId": "trunkId",
                      "scopeId": "scopeId",
                      "sourceCommitSha": "sourceCommitSha",
                      "targetCommitSha": "targetCommitSha",
                      "changes": [
                        {
                          "contextId": "contextId",
                          "contextKey": "contextKey",
                          "sourceRevisionId": "sourceRevisionId",
                          "targetRevisionId": "targetRevisionId"
                        },
                        {
                          "contextId": "contextId",
                          "contextKey": "contextKey",
                          "sourceRevisionId": "sourceRevisionId",
                          "targetRevisionId": "targetRevisionId"
                        }
                      ],
                      "status": "open",
                      "evidenceReference": "evidenceReference",
                      "createdBy": "createdBy",
                      "delegatedActorId": "delegatedActorId",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "mergedBy": "mergedBy",
                      "mergedDelegatedActorId": "mergedDelegatedActorId",
                      "mergedAt": "2024-01-15T09:30:00Z"
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
        let expectedResponse = ListReleasesResponse(
            data: [
                PromotionRequest(
                    id: "id",
                    trunkId: "trunkId",
                    scopeId: "scopeId",
                    sourceCommitSha: "sourceCommitSha",
                    targetCommitSha: Nullable<String>.value("targetCommitSha"),
                    changes: [
                        PromotionRequestChangesItem(
                            contextId: "contextId",
                            contextKey: "contextKey",
                            sourceRevisionId: "sourceRevisionId",
                            targetRevisionId: Nullable<String>.value("targetRevisionId")
                        ),
                        PromotionRequestChangesItem(
                            contextId: "contextId",
                            contextKey: "contextKey",
                            sourceRevisionId: "sourceRevisionId",
                            targetRevisionId: Nullable<String>.value("targetRevisionId")
                        )
                    ],
                    status: PromotionRequestStatus.open,
                    evidenceReference: Optional(Nullable<String>.value("evidenceReference")),
                    createdBy: "createdBy",
                    delegatedActorId: Optional(Nullable<String>.value("delegatedActorId")),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    mergedBy: Optional(Nullable<String>.value("mergedBy")),
                    mergedDelegatedActorId: Optional(Nullable<String>.value("mergedDelegatedActorId")),
                    mergedAt: Optional(Nullable<Date>.value(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)))
                ),
                PromotionRequest(
                    id: "id",
                    trunkId: "trunkId",
                    scopeId: "scopeId",
                    sourceCommitSha: "sourceCommitSha",
                    targetCommitSha: Nullable<String>.value("targetCommitSha"),
                    changes: [
                        PromotionRequestChangesItem(
                            contextId: "contextId",
                            contextKey: "contextKey",
                            sourceRevisionId: "sourceRevisionId",
                            targetRevisionId: Nullable<String>.value("targetRevisionId")
                        ),
                        PromotionRequestChangesItem(
                            contextId: "contextId",
                            contextKey: "contextKey",
                            sourceRevisionId: "sourceRevisionId",
                            targetRevisionId: Nullable<String>.value("targetRevisionId")
                        )
                    ],
                    status: PromotionRequestStatus.open,
                    evidenceReference: Optional(Nullable<String>.value("evidenceReference")),
                    createdBy: "createdBy",
                    delegatedActorId: Optional(Nullable<String>.value("delegatedActorId")),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    mergedBy: Optional(Nullable<String>.value("mergedBy")),
                    mergedDelegatedActorId: Optional(Nullable<String>.value("mergedDelegatedActorId")),
                    mergedAt: Optional(Nullable<Date>.value(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)))
                )
            ],
            nextCursor: Optional(Nullable<String>.value("nextCursor"))
        )
        let response = try await client.releases.list(
            trunkId: "trunkId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func open1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "id": "id",
                  "trunkId": "trunkId",
                  "scopeId": "scopeId",
                  "sourceCommitSha": "sourceCommitSha",
                  "targetCommitSha": "targetCommitSha",
                  "changes": [
                    {
                      "contextId": "contextId",
                      "contextKey": "contextKey",
                      "sourceRevisionId": "sourceRevisionId",
                      "targetRevisionId": "targetRevisionId"
                    }
                  ],
                  "status": "open",
                  "evidenceReference": "evidenceReference",
                  "createdBy": "createdBy",
                  "delegatedActorId": "delegatedActorId",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "mergedBy": "mergedBy",
                  "mergedDelegatedActorId": "mergedDelegatedActorId",
                  "mergedAt": "2024-01-15T09:30:00Z"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = PromotionRequest(
            id: "id",
            trunkId: "trunkId",
            scopeId: "scopeId",
            sourceCommitSha: "sourceCommitSha",
            targetCommitSha: Nullable<String>.value("targetCommitSha"),
            changes: [
                PromotionRequestChangesItem(
                    contextId: "contextId",
                    contextKey: "contextKey",
                    sourceRevisionId: "sourceRevisionId",
                    targetRevisionId: Nullable<String>.value("targetRevisionId")
                )
            ],
            status: PromotionRequestStatus.open,
            evidenceReference: Optional(Nullable<String>.value("evidenceReference")),
            createdBy: "createdBy",
            delegatedActorId: Optional(Nullable<String>.value("delegatedActorId")),
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            mergedBy: Optional(Nullable<String>.value("mergedBy")),
            mergedDelegatedActorId: Optional(Nullable<String>.value("mergedDelegatedActorId")),
            mergedAt: Optional(Nullable<Date>.value(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)))
        )
        let response = try await client.releases.open(
            trunkId: "trunkId",
            request: .init(),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func open2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "id": "id",
                  "trunkId": "trunkId",
                  "scopeId": "scopeId",
                  "sourceCommitSha": "sourceCommitSha",
                  "targetCommitSha": "targetCommitSha",
                  "changes": [
                    {
                      "contextId": "contextId",
                      "contextKey": "contextKey",
                      "sourceRevisionId": "sourceRevisionId",
                      "targetRevisionId": "targetRevisionId"
                    },
                    {
                      "contextId": "contextId",
                      "contextKey": "contextKey",
                      "sourceRevisionId": "sourceRevisionId",
                      "targetRevisionId": "targetRevisionId"
                    }
                  ],
                  "status": "open",
                  "evidenceReference": "evidenceReference",
                  "createdBy": "createdBy",
                  "delegatedActorId": "delegatedActorId",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "mergedBy": "mergedBy",
                  "mergedDelegatedActorId": "mergedDelegatedActorId",
                  "mergedAt": "2024-01-15T09:30:00Z"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = PromotionRequest(
            id: "id",
            trunkId: "trunkId",
            scopeId: "scopeId",
            sourceCommitSha: "sourceCommitSha",
            targetCommitSha: Nullable<String>.value("targetCommitSha"),
            changes: [
                PromotionRequestChangesItem(
                    contextId: "contextId",
                    contextKey: "contextKey",
                    sourceRevisionId: "sourceRevisionId",
                    targetRevisionId: Nullable<String>.value("targetRevisionId")
                ),
                PromotionRequestChangesItem(
                    contextId: "contextId",
                    contextKey: "contextKey",
                    sourceRevisionId: "sourceRevisionId",
                    targetRevisionId: Nullable<String>.value("targetRevisionId")
                )
            ],
            status: PromotionRequestStatus.open,
            evidenceReference: Optional(Nullable<String>.value("evidenceReference")),
            createdBy: "createdBy",
            delegatedActorId: Optional(Nullable<String>.value("delegatedActorId")),
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            mergedBy: Optional(Nullable<String>.value("mergedBy")),
            mergedDelegatedActorId: Optional(Nullable<String>.value("mergedDelegatedActorId")),
            mergedAt: Optional(Nullable<Date>.value(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)))
        )
        let response = try await client.releases.open(
            trunkId: "trunkId",
            request: .init(),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func merge1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "id": "id",
                  "trunkId": "trunkId",
                  "scopeId": "scopeId",
                  "sourceCommitSha": "sourceCommitSha",
                  "targetCommitSha": "targetCommitSha",
                  "changes": [
                    {
                      "contextId": "contextId",
                      "contextKey": "contextKey",
                      "sourceRevisionId": "sourceRevisionId",
                      "targetRevisionId": "targetRevisionId"
                    }
                  ],
                  "status": "open",
                  "evidenceReference": "evidenceReference",
                  "createdBy": "createdBy",
                  "delegatedActorId": "delegatedActorId",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "mergedBy": "mergedBy",
                  "mergedDelegatedActorId": "mergedDelegatedActorId",
                  "mergedAt": "2024-01-15T09:30:00Z"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = PromotionRequest(
            id: "id",
            trunkId: "trunkId",
            scopeId: "scopeId",
            sourceCommitSha: "sourceCommitSha",
            targetCommitSha: Nullable<String>.value("targetCommitSha"),
            changes: [
                PromotionRequestChangesItem(
                    contextId: "contextId",
                    contextKey: "contextKey",
                    sourceRevisionId: "sourceRevisionId",
                    targetRevisionId: Nullable<String>.value("targetRevisionId")
                )
            ],
            status: PromotionRequestStatus.open,
            evidenceReference: Optional(Nullable<String>.value("evidenceReference")),
            createdBy: "createdBy",
            delegatedActorId: Optional(Nullable<String>.value("delegatedActorId")),
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            mergedBy: Optional(Nullable<String>.value("mergedBy")),
            mergedDelegatedActorId: Optional(Nullable<String>.value("mergedDelegatedActorId")),
            mergedAt: Optional(Nullable<Date>.value(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)))
        )
        let response = try await client.releases.merge(
            trunkId: "trunkId",
            promotionId: "promotionId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func merge2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "id": "id",
                  "trunkId": "trunkId",
                  "scopeId": "scopeId",
                  "sourceCommitSha": "sourceCommitSha",
                  "targetCommitSha": "targetCommitSha",
                  "changes": [
                    {
                      "contextId": "contextId",
                      "contextKey": "contextKey",
                      "sourceRevisionId": "sourceRevisionId",
                      "targetRevisionId": "targetRevisionId"
                    },
                    {
                      "contextId": "contextId",
                      "contextKey": "contextKey",
                      "sourceRevisionId": "sourceRevisionId",
                      "targetRevisionId": "targetRevisionId"
                    }
                  ],
                  "status": "open",
                  "evidenceReference": "evidenceReference",
                  "createdBy": "createdBy",
                  "delegatedActorId": "delegatedActorId",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "mergedBy": "mergedBy",
                  "mergedDelegatedActorId": "mergedDelegatedActorId",
                  "mergedAt": "2024-01-15T09:30:00Z"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = PromotionRequest(
            id: "id",
            trunkId: "trunkId",
            scopeId: "scopeId",
            sourceCommitSha: "sourceCommitSha",
            targetCommitSha: Nullable<String>.value("targetCommitSha"),
            changes: [
                PromotionRequestChangesItem(
                    contextId: "contextId",
                    contextKey: "contextKey",
                    sourceRevisionId: "sourceRevisionId",
                    targetRevisionId: Nullable<String>.value("targetRevisionId")
                ),
                PromotionRequestChangesItem(
                    contextId: "contextId",
                    contextKey: "contextKey",
                    sourceRevisionId: "sourceRevisionId",
                    targetRevisionId: Nullable<String>.value("targetRevisionId")
                )
            ],
            status: PromotionRequestStatus.open,
            evidenceReference: Optional(Nullable<String>.value("evidenceReference")),
            createdBy: "createdBy",
            delegatedActorId: Optional(Nullable<String>.value("delegatedActorId")),
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            mergedBy: Optional(Nullable<String>.value("mergedBy")),
            mergedDelegatedActorId: Optional(Nullable<String>.value("mergedDelegatedActorId")),
            mergedAt: Optional(Nullable<Date>.value(try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)))
        )
        let response = try await client.releases.merge(
            trunkId: "trunkId",
            promotionId: "promotionId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}