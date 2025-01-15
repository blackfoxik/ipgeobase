# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"
require "simplecov"
SimpleCov.start

class TestIpgeobase < Minitest::Test
  def setup
    raw_response_file = File.new(File.join(__dir__, "xml_response.xml"))
    stub_request(:any, /ip-api.com/).to_return(body: raw_response_file, status: 200)
    @ip_meta = Ipgeobase.lookup("8.8.8.8")
  end

  def teardown
    @ip_meta = nil
  end

  def test_has_metadata
    raw_response_file = File.new(File.join(__dir__, "xml_response.xml"))
    stub_request(:any, /ip-api.com/).to_return(body: raw_response_file, status: 200)

    metadata = Ipgeobase.lookup("8.8.8.8")
    refute_nil metadata
  end

  def test_city
    assert @ip_meta.city == "Ashburn"
  end

  def test_country
    assert @ip_meta.country == "United States"
  end

  def test_country_code
    assert @ip_meta.countryCode == "US"
  end

  def test_lat
    refute_nil @ip_meta.lat
  end

  def test_lon
    refute_nil @ip_meta.lon
  end

  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end
end
