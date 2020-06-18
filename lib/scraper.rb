class GetParks
attr_accessor :parkset, :location

  def initialize(location)
    @location = location
    self.parks_by_state
  end

  def get_parks
    uri = URI.parse("https://developer.nps.gov/api/v1/parks?stateCode=#{@location}&api_key=MoMOpUwdmOP1d9ZbR8P2NyDm4746f3ewpweDR7R5")
    response = Net::HTTP.get_response(uri)
    response.body
  end

  def parks_by_state
    parks = JSON.parse(self.get_parks)
    @parkset = parks["data"]
    if parkset.empty?
      puts "That request returns no matching parks."
    end
    Park.new_from_array(parkset)
  end

  # def park_att
  #   attributes = []
  #     self.parks_by_state
  #     @parkset.each do |park|
  #         park.each do |k, v|
  #           park.send("#{k}=", v)
  #         end
  #       end
  #       binding.pry
  #   end
end
