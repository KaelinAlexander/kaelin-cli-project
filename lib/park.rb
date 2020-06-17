class Park
attr_accessor :list_number, :name, :raw_address, :address, :fees, :description, :website
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
      counter = 1
      park.each do |k,v|
        @raw_address = []
        @name = park["name"]
        @fees = park["entranceFees"][0]["description"]
        park["addresses"].each do |address|
            if address["type"] == "Physical"
              @raw_address << address
            end
        end
        @description = park["description"]
        @website = park["url"]
      end
  end

  def save
    @@all << self
  end

  def get_index(park)
    index = Park.all.find_index(self)
    @list_number = index + 1
  end

end
