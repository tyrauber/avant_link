module AvantLink
  class Request
    require 'http'
    require 'ostruct'
    require 'crack'

    $connection = HTTP.persistent "https://classic.avantlink.com"

    attr_accessor :response, :output

    def initialize(endpoint, options)
      options  = AvantLink.options.merge(options).merge(module: endpoint)
      options[:output] ||= 'xml'
      self.output = options[:output]
      options = options.reject { |k,v| v.nil? || v == '' }

      self.class.required.each do |k|
        raise ArgumentError, "Parameter '#{k.to_s}' is required" unless !!(options[k])     
      end

      uri = "/api.php?#{to_params(options)}"
      @response = $connection.get(uri.to_s)
      @response.flush
    end

    def self.required
      [:affiliate_id, :website_id]
    end
    
    def self.where(options = {})
      request = new(self.name.gsub('AvantLink::',''), options)
      request.parse_response
    end
    
    def parse_response
      case @response.code
      when 200
        response_success(@response)
      else
        response_error(@response)
      end
    end

    def to_params(options)
      options.map { |k,v| "#{k}=#{v.to_s.gsub(" ", "+")}" }.join("&")
    end

    protected

    def response_success(response)
      if self.output.to_s == 'OpenStruct'
        JSON.parse(response, object_class: OpenStruct)
      elsif self.output.to_s == 'json'
        JSON.parse(response)
      elsif self.output.to_s == 'xml'
        response = Crack::XML.parse(response)
        if response['NewDataSet']
          if response['NewDataSet']['Table1']
            response['NewDataSet']['Table1']
          else
            []
          end
        elsif response['Root'] && response['Root']['Product']
          response['Root']['Product']
        elsif response['response'] && response['response']['url']
          response['response']['url']
        else
          response
        end
      else
        response
      end
    end

    def response_error(response)
      {
        code: response.code,
        body: response.body
      }
    end
  end

  class AdSearch < Request
    def self.required
      [:affiliate_id, :website_id, :merchant_id]
    end
  end

  class CustomLink < Request
    def self.required
      [:affiliate_id, :website_id, :merchant_id]
    end
  end

  class DotdFeed < Request
  end

  class ProductPriceCheck < Request
    def self.required
      [:affiliate_id, :website_id, :merchant_id, :sku]
    end
  end

  class ProductSearch < Request
    def self.required
      [:affiliate_id, :website_id, :search_term]
    end
  end

  class ProductTaxonomy < Request
    def self.required
      [:affiliate_id, :website_id, :merchant_id]
    end
  end

  class ProductContent < Request
    def self.required
      [:website_id, :merchant_id]
    end
  end

  class AssociationFeed < Request
    def self.required
      [:auth_key, :affiliate_id, :website_id]
    end
  end

  class SubscriptionFeed < Request
    def self.required
      [:auth_key, :affiliate_id, :website_id]
    end
  end

  class WebsiteFeed < Request
    def self.required
      [:auth_key, :affiliate_id, :website_id]
    end
  end
end