import Foundation
import Testing
import AgentTrunk

@Suite("BillingClient Wire Tests") struct BillingClientWireTests {
    @Test func get1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "plan": "free",
                  "accesses": 1,
                  "includedAccesses": 1,
                  "spendLimitCents": 1,
                  "meteringActive": "meteringActive",
                  "canManage": true,
                  "subscriptionStatus": "subscriptionStatus",
                  "monthlyPriceCents": 1,
                  "overageCents": 1,
                  "overageCentsPerThousand": 1,
                  "period": "period",
                  "hasCustomer": true
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = GetBillingResponse(
            plan: GetBillingResponsePlan.free,
            accesses: 1,
            includedAccesses: Nullable<Int>.value(1),
            spendLimitCents: 1,
            meteringActive: "meteringActive",
            canManage: true,
            subscriptionStatus: Optional("subscriptionStatus"),
            monthlyPriceCents: Optional(1),
            overageCents: Optional(1),
            overageCentsPerThousand: Optional(Nullable<Int>.value(1)),
            period: Optional("period"),
            hasCustomer: Optional(true)
        )
        let response = try await client.billing.get(requestOptions: RequestOptions(additionalHeaders: stub.headers))
        try #require(response == expectedResponse)
    }

    @Test func get2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "plan": "free",
                  "accesses": 1,
                  "includedAccesses": 1,
                  "spendLimitCents": 1000000,
                  "meteringActive": "meteringActive",
                  "canManage": true,
                  "subscriptionStatus": "subscriptionStatus",
                  "monthlyPriceCents": 1,
                  "overageCents": 1,
                  "overageCentsPerThousand": 1,
                  "period": "period",
                  "hasCustomer": true
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = GetBillingResponse(
            plan: GetBillingResponsePlan.free,
            accesses: 1,
            includedAccesses: Nullable<Int>.value(1),
            spendLimitCents: 1000000,
            meteringActive: "meteringActive",
            canManage: true,
            subscriptionStatus: Optional("subscriptionStatus"),
            monthlyPriceCents: Optional(1),
            overageCents: Optional(1),
            overageCentsPerThousand: Optional(Nullable<Int>.value(1)),
            period: Optional("period"),
            hasCustomer: Optional(true)
        )
        let response = try await client.billing.get(requestOptions: RequestOptions(additionalHeaders: stub.headers))
        try #require(response == expectedResponse)
    }

    @Test func createCheckout1() async throws -> Void {
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
        let expectedResponse = CreateCheckoutBillingResponse(
            url: "url"
        )
        let response = try await client.billing.createCheckout(
            request: .init(plan: .starter),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func createCheckout2() async throws -> Void {
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
        let expectedResponse = CreateCheckoutBillingResponse(
            url: "url"
        )
        let response = try await client.billing.createCheckout(
            request: .init(plan: .starter),
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
        let expectedResponse = CreatePortalBillingResponse(
            url: "url"
        )
        let response = try await client.billing.createPortal(requestOptions: RequestOptions(additionalHeaders: stub.headers))
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
        let expectedResponse = CreatePortalBillingResponse(
            url: "url"
        )
        let response = try await client.billing.createPortal(requestOptions: RequestOptions(additionalHeaders: stub.headers))
        try #require(response == expectedResponse)
    }

    @Test func setSpendLimit1() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "spendLimitCents": 1
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = SetSpendLimitBillingResponse(
            spendLimitCents: 1
        )
        let response = try await client.billing.setSpendLimit(
            request: .init(cents: 1),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }

    @Test func setSpendLimit2() async throws -> Void {
        let stub = HTTPStub()
        stub.setResponse(
            body: Foundation.Data(
                #"""
                {
                  "spendLimitCents": 1
                }
                """#.utf8
            )
        )
        let client = AgentTrunk(
            baseURL: "https://api.fern.com",
            accessToken: "<token>",
            urlSession: stub.urlSession
        )
        let expectedResponse = SetSpendLimitBillingResponse(
            spendLimitCents: 1
        )
        let response = try await client.billing.setSpendLimit(
            request: .init(cents: 1000000),
            requestOptions: RequestOptions(additionalHeaders: stub.headers)
        )
        try #require(response == expectedResponse)
    }
}