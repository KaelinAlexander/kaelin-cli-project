require 'pry'
require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'json'

class GetParks
attr_accessor :zipcode

  # def initialize
  #   URL = "https://developer.nps.gov/api/v1/parks?api_key=MoMOpUwdmOP1d9ZbR8P2NyDm4746f3ewpweDR7R5"
  # end

  def get_parks
    uri = URI.parse("https://developer.nps.gov/api/v1/parks?api_key=MoMOpUwdmOP1d9ZbR8P2NyDm4746f3ewpweDR7R5")
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def parks_by_zip
    local = []
    parks = JSON.parse(self.get_parks)
    data = parks["data"]# parks.each do |k,v|
    #   if
    binding.pry
  end

end
#
parks = GetParks.new
parsed = parks.parks_by_zip
