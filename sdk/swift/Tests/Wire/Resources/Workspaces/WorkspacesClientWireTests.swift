import Foundation
import Testing
import AgentTrunk

@Suite("WorkspacesClient Wire Tests") struct WorkspacesClientWireTests {
    @Test func list1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "nextCursor": "nextCursor",
                  "data": [
                    {
                      "id": "id",
                      "organizationId": "organizationId",
                      "name": "name",
                      "slug": "slug",
                      "createdBy": "createdBy",
                      "branches": {
                        "staging": null,
                        "production": null
                      },
                      "createdAt": "2024-01-15T09:30:00Z"
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
        let expectedResponse = ListWorkspacesResponse(
            nextCursor: Optional(Nullable<String>.value("nextCursor")),
            data: [
                Trunk(
                    id: "id",
                    organizationId: "organizationId",
                    name: "name",
                    slug: "slug",
                    createdBy: "createdBy",
                    branches: TrunkBranches(
                        staging: .null,
                        production: .null
                    ),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
                )
            ]
        )
        let response = try await client.workspaces.list(requestOptions: RequestOptions(additionalHeaders: stub.headers))
        try #require(response == expectedResponse)
    }

    @Test func list2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "nextCursor": "nextCursor",
                  "data": [
                    {
                      "id": "id",
                      "organizationId": "organizationId",
                      "name": "name",
                      "slug": "slug",
                      "createdBy": "createdBy",
                      "branches": {
                        "staging": "staging",
                        "production": "production"
                      },
                      "createdAt": "2024-01-15T09:30:00Z"
                    },
                    {
                      "id": "id",
                      "organizationId": "organizationId",
                      "name": "name",
                      "slug": "slug",
                      "createdBy": "createdBy",
                      "branches": {
                        "staging": "staging",
                        "production": "production"
                      },
                      "createdAt": "2024-01-15T09:30:00Z"
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
        let expectedResponse = ListWorkspacesResponse(
            nextCursor: Optional(Nullable<String>.value("nextCursor")),
            data: [
                Trunk(
                    id: "id",
                    organizationId: "organizationId",
                    name: "name",
                    slug: "slug",
                    createdBy: "createdBy",
                    branches: TrunkBranches(
                        staging: Nullable<String>.value("staging"),
                        production: Nullable<String>.value("production")
                    ),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
                ),
                Trunk(
                    id: "id",
                    organizationId: "organizationId",
                    name: "name",
                    slug: "slug",
                    createdBy: "createdBy",
                    branches: TrunkBranches(
                        staging: Nullable<String>.value("staging"),
                        production: Nullable<String>.value("production")
                    ),
                    createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
                )
            ]
        )
        let response = try await client.workspaces.list(requestOptions: RequestOptions(additionalHeaders: stub.headers))
        try #require(response == expectedResponse)
    }

    @Test func create1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "id": "id",
                  "organizationId": "organizationId",
                  "name": "name",
                  "slug": "slug",
                  "createdBy": "createdBy",
                  "branches": {
                    "staging": "staging",
                    "production": "production"
                  },
                  "createdAt": "2024-01-15T09:30:00Z"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = Trunk(
            id: "id",
            organizationId: "organizationId",
            name: "name",
            slug: "slug",
            createdBy: "createdBy",
            branches: TrunkBranches(
                staging: Nullable<String>.value("staging"),
                production: Nullable<String>.value("production")
            ),
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
        )
        let response = try await client.workspaces.create(
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
                  "id": "id",
                  "organizationId": "organizationId",
                  "name": "name",
                  "slug": "slug",
                  "createdBy": "createdBy",
                  "branches": {
                    "staging": "staging",
                    "production": "production"
                  },
                  "createdAt": "2024-01-15T09:30:00Z"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = Trunk(
            id: "id",
            organizationId: "organizationId",
            name: "name",
            slug: "slug",
            createdBy: "createdBy",
            branches: TrunkBranches(
                staging: Nullable<String>.value("staging"),
                production: Nullable<String>.value("production")
            ),
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
        )
        let response = try await client.workspaces.create(
            request: .init(name: "x"),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func get1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "id": "id",
                  "organizationId": "organizationId",
                  "name": "name",
                  "slug": "slug",
                  "createdBy": "createdBy",
                  "branches": {
                    "staging": "staging",
                    "production": "production"
                  },
                  "createdAt": "2024-01-15T09:30:00Z"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = Trunk(
            id: "id",
            organizationId: "organizationId",
            name: "name",
            slug: "slug",
            createdBy: "createdBy",
            branches: TrunkBranches(
                staging: Nullable<String>.value("staging"),
                production: Nullable<String>.value("production")
            ),
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
        )
        let response = try await client.workspaces.get(
            trunkId: "trunkId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func get2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "id": "id",
                  "organizationId": "organizationId",
                  "name": "name",
                  "slug": "slug",
                  "createdBy": "createdBy",
                  "branches": {
                    "staging": "staging",
                    "production": "production"
                  },
                  "createdAt": "2024-01-15T09:30:00Z"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = Trunk(
            id: "id",
            organizationId: "organizationId",
            name: "name",
            slug: "slug",
            createdBy: "createdBy",
            branches: TrunkBranches(
                staging: Nullable<String>.value("staging"),
                production: Nullable<String>.value("production")
            ),
            createdAt: try! Date("2024-01-15T09:30:00Z", strategy: .iso8601)
        )
        let response = try await client.workspaces.get(
            trunkId: "trunkId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func audit1() async throws -> Void {
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
        let response = try await client.workspaces.audit(
            trunkId: "trunkId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func audit2() async throws -> Void {
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
        let response = try await client.workspaces.audit(
            trunkId: "trunkId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}