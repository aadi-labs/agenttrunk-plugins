# frozen_string_literal: true

module AgentTrunk
  module Billing
    class Client
      # @param client [AgentTrunk::Internal::Http::RawClient]
      #
      # @return [void]
      def initialize(client:)
        @client = client
      end

      # Organization subscription and usage summary. Requires billing:read. MCP metering is currently inactive.
      #
      # @param request_options [Hash]
      # @param _params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.billing.get
      #
      # @return [AgentTrunk::Billing::Types::GetBillingResponse]
      def get(request_options: {}, **_params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "GET",
          path: "v1/billing",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise AgentTrunk::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          AgentTrunk::Billing::Types::GetBillingResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # Requires billing:manage. Reuses an unexpired checkout; existing subscriptions must use the portal. Body limited
      # to 4096 bytes.
      #
      # @param request_options [Hash]
      # @param params [AgentTrunk::Billing::Types::CreateCheckoutBillingRequest]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.billing.create_checkout(plan: "starter")
      #
      # @return [AgentTrunk::Billing::Types::CreateCheckoutBillingResponse]
      def create_checkout(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/billing/checkout",
          body: AgentTrunk::Billing::Types::CreateCheckoutBillingRequest.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise AgentTrunk::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          AgentTrunk::Billing::Types::CreateCheckoutBillingResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # Requires billing:manage and an existing organization customer.
      #
      # @param request_options [Hash]
      # @param _params [Hash]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.billing.create_portal
      #
      # @return [AgentTrunk::Billing::Types::CreatePortalBillingResponse]
      def create_portal(request_options: {}, **_params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/billing/portal",
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise AgentTrunk::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          AgentTrunk::Billing::Types::CreatePortalBillingResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end

      # Requires billing:manage. Audited organization overage cap; excludes subscription fees and taxes. Does not
      # activate metering.
      #
      # @param request_options [Hash]
      # @param params [AgentTrunk::Billing::Types::SetSpendLimitBillingRequest]
      # @option request_options [String] :base_url
      # @option request_options [Hash{String => Object}] :additional_headers
      # @option request_options [Hash{String => Object}] :additional_query_parameters
      # @option request_options [Hash{String => Object}] :additional_body_parameters
      # @option request_options [Integer] :timeout_in_seconds
      #
      # @example
      #   client.billing.set_spend_limit(cents: 1)
      #
      # @return [AgentTrunk::Billing::Types::SetSpendLimitBillingResponse]
      def set_spend_limit(request_options: {}, **params)
        params = AgentTrunk::Internal::Types::Utils.normalize_keys(params)
        request = AgentTrunk::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: "POST",
          path: "v1/billing/spend-limit",
          body: AgentTrunk::Billing::Types::SetSpendLimitBillingRequest.new(params).to_h,
          request_options: request_options
        )
        begin
          response = @client.send(request)
        rescue Net::HTTPRequestTimeout
          raise AgentTrunk::Errors::TimeoutError
        end
        code = response.code.to_i
        if code.between?(200, 299)
          AgentTrunk::Billing::Types::SetSpendLimitBillingResponse.load(response.body)
        else
          error_class = AgentTrunk::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code)
        end
      end
    end
  end
end
