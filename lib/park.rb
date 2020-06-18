class Park
attr_accessor :list_number, :name, :designation, :raw_address, :fees, :description, :website, :address
@@all = []

  def initialize(park)
    generate_attributes(park)
    save
    get_index(park)
  end

  def self.all
    @@all
  end

  def self.new_from_array(parkset)
    parkset.each do |park|
      new(park)
    end
  end

  def generate_attributes(park)
      park.each do |k,v|
        @raw_address = []
        @name = park["name"]
        @designation = park["designation"]
        # @fees = park["entranceFees"][0]["description"]
        park["addresses"].each do |address|
            if address["type"] == "Physical"
              @raw_address << address.to_h
            cleanup(@raw_address)
            end
        end
        @description = park["description"]
        @website = park["url"]
      end
  end

  def cleanup(raw)
      self.address = "#{raw[0]["line1"]}\n#{raw[0]["city"]}, #{raw[0]["stateCode"]} #{raw[0]["postalCode"]}"
  end

  def save
    @@all << self
  end

  def get_index(park)
    index = Park.all.find_index(self)
    @list_number = index + 1
  end

  def self.find_by_number(selection)
    all.find{|park| park.list_number == selection}
  end
end
