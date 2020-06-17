require 'pry'

class User
attr_accessor :location
@@states = ['AL', 'AK', 'AS', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FM', 'FL', 'GA', 'GU', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MH', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'MP', 'OH', 'OK', 'OR', 'PW', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VI', 'VA', 'WA', 'WV', 'WI', 'WY' ]

  def call
    puts "Welcome the National Parks Directory!"
    menu
    options
  end

  def menu
    while @input != "exit"
      puts "Please enter the two-character abbreviation for the state whose parks you'd like to know about."
      input = gets.strip.upcase.to_s
      if @@states.include?(input)
          @location = input
          list_parks(location)
      else
          puts "Sorry, I didn't understand that. Please enter a valid, two-letter state abbreviation."
      end
    end
  end

  def list_parks(location)
    puts "Great! Let's find out about all the National Parks in #{@location}. Give me just a minute..."
    GetParks.new(location)
    Park.all.each{|park| puts "#{park.list_number}. #{park.name}"}
    # List the parks by name and index + 1.

    #Allow the user to select a number for more details.
  end

  def options
    puts "If you're done for the day, type 'exit,' or enter another state abbreviation to find out about more National Parks."
    menu
  end

end
