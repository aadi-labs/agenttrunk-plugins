import Foundation
import Testing
import AgentTrunk

@Suite("ScopesClient Wire Tests") struct ScopesClientWireTests {
    @Test func list1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "data": [
                    {
                      "canCreateScope": true,
                      "id": "id",
                      "name": "name",
                      "slug": "slug",
                      "createdBy": "createdBy",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "environments": [
                        {
                          "id": "id",
                          "name": "staging",
                          "commitSha": null
                        }
                      ]
                    }
                  ]
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = ListScopesResponse(
            data: [
                Scope(
                    canCreateScope: Optional(true),
                    id: "id",
                    name: "name",
                    slug: "slug",
                    createdBy: "createdBy",
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    environments: [
                        ScopeEnvironmentsItem(
                            id: "id",
                            name: ScopeEnvironmentsItemName.staging,
                            commitSha: .null
                        )
                    ]
                )
            ]
        )
        let response = try await client.scopes.list(
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
                      "canCreateScope": true,
                      "id": "id",
                      "name": "name",
                      "slug": "slug",
                      "createdBy": "createdBy",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "environments": [
                        {
                          "id": "id",
                          "name": "staging",
                          "commitSha": "commitSha",
                          "canDeploy": true,
                          "canPropose": true,
                          "canPublish": true
                        },
                        {
                          "id": "id",
                          "name": "staging",
                          "commitSha": "commitSha",
                          "canDeploy": true,
                          "canPropose": true,
                          "canPublish": true
                        }
                      ]
                    },
                    {
                      "canCreateScope": true,
                      "id": "id",
                      "name": "name",
                      "slug": "slug",
                      "createdBy": "createdBy",
                      "createdAt": "2024-01-15T09:30:00Z",
                      "environments": [
                        {
                          "id": "id",
                          "name": "staging",
                          "commitSha": "commitSha",
                          "canDeploy": true,
                          "canPropose": true,
                          "canPublish": true
                        },
                        {
                          "id": "id",
                          "name": "staging",
                          "commitSha": "commitSha",
                          "canDeploy": true,
                          "canPropose": true,
                          "canPublish": true
                        }
                      ]
                    }
                  ]
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = ListScopesResponse(
            data: [
                Scope(
                    canCreateScope: Optional(true),
                    id: "id",
                    name: "name",
                    slug: "slug",
                    createdBy: "createdBy",
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    environments: [
                        ScopeEnvironmentsItem(
                            id: "id",
                            name: ScopeEnvironmentsItemName.staging,
                            commitSha: Nullable<String>.value("commitSha"),
                            canDeploy: Optional(true),
                            canPropose: Optional(true),
                            canPublish: Optional(true)
                        ),
                        ScopeEnvironmentsItem(
                            id: "id",
                            name: ScopeEnvironmentsItemName.staging,
                            commitSha: Nullable<String>.value("commitSha"),
                            canDeploy: Optional(true),
                            canPropose: Optional(true),
                            canPublish: Optional(true)
                        )
                    ]
                ),
                Scope(
                    canCreateScope: Optional(true),
                    id: "id",
                    name: "name",
                    slug: "slug",
                    createdBy: "createdBy",
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
                    environments: [
                        ScopeEnvironmentsItem(
                            id: "id",
                            name: ScopeEnvironmentsItemName.staging,
                            commitSha: Nullable<String>.value("commitSha"),
                            canDeploy: Optional(true),
                            canPropose: Optional(true),
                            canPublish: Optional(true)
                        ),
                        ScopeEnvironmentsItem(
                            id: "id",
                            name: ScopeEnvironmentsItemName.staging,
                            commitSha: Nullable<String>.value("commitSha"),
                            canDeploy: Optional(true),
                            canPropose: Optional(true),
                            canPublish: Optional(true)
                        )
                    ]
                )
            ]
        )
        let response = try await client.scopes.list(
            trunkId: "trunkId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func create1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "canCreateScope": true,
                  "id": "id",
                  "name": "name",
                  "slug": "slug",
                  "createdBy": "createdBy",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "environments": [
                    {
                      "id": "id",
                      "name": "staging",
                      "commitSha": "commitSha",
                      "canDeploy": true,
                      "canPropose": true,
                      "canPublish": true
                    }
                  ]
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = Scope(
            canCreateScope: Optional(true),
            id: "id",
            name: "name",
            slug: "slug",
            createdBy: "createdBy",
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            environments: [
                ScopeEnvironmentsItem(
                    id: "id",
                    name: ScopeEnvironmentsItemName.staging,
                    commitSha: Nullable<String>.value("commitSha"),
                    canDeploy: Optional(true),
                    canPropose: Optional(true),
                    canPublish: Optional(true)
                )
            ]
        )
        let response = try await client.scopes.create(
            trunkId: "trunkId",
            request: .init(name: "name"),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func create2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "canCreateScope": true,
                  "id": "id",
                  "name": "name",
                  "slug": "slug",
                  "createdBy": "createdBy",
                  "createdAt": "2024-01-15T09:30:00Z",
                  "environments": [
                    {
                      "id": "id",
                      "name": "staging",
                      "commitSha": "commitSha",
                      "canDeploy": true,
                      "canPropose": true,
                      "canPublish": true
                    },
                    {
                      "id": "id",
                      "name": "staging",
                      "commitSha": "commitSha",
                      "canDeploy": true,
                      "canPropose": true,
                      "canPublish": true
                    }
                  ]
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = Scope(
            canCreateScope: Optional(true),
            id: "id",
            name: "name",
            slug: "slug",
            createdBy: "createdBy",
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601),
            environments: [
                ScopeEnvironmentsItem(
                    id: "id",
                    name: ScopeEnvironmentsItemName.staging,
                    commitSha: Nullable<String>.value("commitSha"),
                    canDeploy: Optional(true),
                    canPropose: Optional(true),
                    canPublish: Optional(true)
                ),
                ScopeEnvironmentsItem(
                    id: "id",
                    name: ScopeEnvironmentsItemName.staging,
                    commitSha: Nullable<String>.value("commitSha"),
                    canDeploy: Optional(true),
                    canPropose: Optional(true),
                    canPublish: Optional(true)
                )
            ]
        )
        let response = try await client.scopes.create(
            trunkId: "trunkId",
            request: .init(name: "x"),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}