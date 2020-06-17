class Park
attr_accessor :list_number, :name, :address, :fees, :description
@@all = []

  def initialize(park)
    generate_attributes(park)
    save
  end

  def self.all
    @@all
  end

  def self.new_from_array(parkset)
    parkset.each do |park|
      new(park)
      binding.pry
    end
  end

  def generate_attributes(park)
      park.each do |k,v|
        send("#{k}=", v)
      end
  end

  def save
    @@all << self
  end

end
