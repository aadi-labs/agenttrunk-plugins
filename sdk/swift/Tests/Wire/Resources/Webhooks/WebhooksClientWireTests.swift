import Foundation
import Testing
import AgentTrunk

@Suite("WebhooksClient Wire Tests") struct WebhooksClientWireTests {
    @Test func list1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "nextCursor": "nextCursor",
                  "data": [
                    {
                      "sequence": "sequence",
                      "eventId": "eventId",
                      "status": "pending",
                      "attempts": 1,
                      "lastError": "lastError",
                      "svixMessageId": "svixMessageId"
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
        let expectedResponse = ListWebhooksResponse(
            nextCursor: Nullable<String>.value("nextCursor"),
            data: [
                ListWebhooksResponseDataItem(
                    sequence: Optional("sequence"),
                    eventId: Optional("eventId"),
                    status: Optional(ListWebhooksResponseDataItemStatus.pending),
                    attempts: Optional(1),
                    lastError: Optional(Nullable<String>.value("lastError")),
                    svixMessageId: Optional(Nullable<String>.value("svixMessageId"))
                )
            ]
        )
        let response = try await client.webhooks.list(
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
                  "nextCursor": "nextCursor",
                  "data": [
                    {
                      "sequence": "sequence",
                      "eventId": "eventId",
                      "status": "pending",
                      "attempts": 1,
                      "lastError": "lastError",
                      "svixMessageId": "svixMessageId"
                    },
                    {
                      "sequence": "sequence",
                      "eventId": "eventId",
                      "status": "pending",
                      "attempts": 1,
                      "lastError": "lastError",
                      "svixMessageId": "svixMessageId"
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
        let expectedResponse = ListWebhooksResponse(
            nextCursor: Nullable<String>.value("nextCursor"),
            data: [
                ListWebhooksResponseDataItem(
                    sequence: Optional("sequence"),
                    eventId: Optional("eventId"),
                    status: Optional(ListWebhooksResponseDataItemStatus.pending),
                    attempts: Optional(1),
                    lastError: Optional(Nullable<String>.value("lastError")),
                    svixMessageId: Optional(Nullable<String>.value("svixMessageId"))
                ),
                ListWebhooksResponseDataItem(
                    sequence: Optional("sequence"),
                    eventId: Optional("eventId"),
                    status: Optional(ListWebhooksResponseDataItemStatus.pending),
                    attempts: Optional(1),
                    lastError: Optional(Nullable<String>.value("lastError")),
                    svixMessageId: Optional(Nullable<String>.value("svixMessageId"))
                )
            ]
        )
        let response = try await client.webhooks.list(
            trunkId: "trunkId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func createPortal1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "url": "url"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = CreatePortalWebhooksResponse(
            url: "url"
        )
        let response = try await client.webhooks.createPortal(
            trunkId: "trunkId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func createPortal2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "url": "url"
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = CreatePortalWebhooksResponse(
            url: "url"
        )
        let response = try await client.webhooks.createPortal(
            trunkId: "trunkId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func retry1() async throws -> Void {
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
        let response = try await client.webhooks.retry(
            trunkId: "trunkId",
            eventId: "eventId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func retry2() async throws -> Void {
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
        let response = try await client.webhooks.retry(
            trunkId: "trunkId",
            eventId: "eventId",
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}