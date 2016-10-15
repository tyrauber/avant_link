require 'rubygems'
require 'avant_link/version'
require 'avant_link/request'

module AvantLink

  def self.options
    self.configuration.to_h
  end

  class << self
    attr_accessor :configuration
    
    def reset
      @configuration = Configuration.new
    end
  end

  def self.configure(&block)
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :auth_key, :affiliate_id, :website_id, :merchant_id, :output

    def initialize(opts={})
      @output ||= opts[:output] || 'xml'
      @auth_key ||= opts[:auth_key]
      @affiliate_id ||= opts[:affiliate_id]
      @website_id ||= opts[:website_id]
      @merchant_id ||= opts[:merchant_id]
    end

    def to_h(hash={})
      instance_variables.each {|var| hash[var.to_s.delete("@").to_sym] = instance_variable_get(var) }
      hash
    end
  end
end