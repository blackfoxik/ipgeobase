# frozen_string_literal: true

require_relative "ipgeobase/version"
require "net/http"
require "happymapper"

module Ipgeobase
  class Error < StandardError; end

  class MetaData
    include HappyMapper

    tag "query"
    element :city, String, tag: "city"
    element :country, String, tag: "country"
    element :countryCode, String, tag: "countryCode"
    element :lat, Float, tag: "lat"
    element :lon, Float, tag: "lon"
  end

  # Your code goes here...
  def self.lookup(ip_address)
    uri = URI("http://ip-api.com/xml/#{ip_address}")
    raw_res = Net::HTTP.get(uri)

    MetaData.parse(raw_res.to_s)
  end
end
