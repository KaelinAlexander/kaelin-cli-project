require 'pry'

class User
attr_accessor :location, :selection, :parks_in_state
@@states = ['AL', 'AK', 'AS', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FM', 'FL', 'GA', 'GU', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MH', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'MP', 'OH', 'OK', 'OR', 'PW', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VI', 'VA', 'WA', 'WV', 'WI', 'WY' ]
@@states_no_parks = ['AL', 'CT', 'DE', 'GA', 'ID', 'IL', 'IA', 'KS', 'LA', 'MD', 'MA', 'MS', 'NE', 'NH', 'NJ', 'NY', 'OK', 'PA', 'RI', 'VT', 'WV', 'WI']
  def call
    puts "***Welcome the National Parks Directory!***"
    puts "\n"
    puts "With this CLI, you can find out about National Parks in your state, \nor wherever your travels might take you."
    puts "\n"
    sleep(2)
    menu
  end

  def menu
    puts "Please enter the two-letter postal abbreviation for the state \nwhose parks you'd like to know about. Or, type 'exit' to exit the CLI."
      input = gets.strip.upcase.to_s
      if input = "EXIT"
        goodbye
      elsif @@states.include?(input)
          @location = input
          if @@states_no_parks.include?(location)
            puts "\n"
            puts "It may surprise you to learn that there aren't any National Parks in that state. \nWeird, right?"
            puts "\n"
            sleep(3)
            menu
          else
            get_parks(location)
          end
      else
          puts "Sorry, I didn't understand that."
          puts "\n"
          sleep(1)
          menu
      end
  end

  def get_parks(location)
    puts "\n"
    puts "Great! Let's find out about all the National Parks in #{@location}. \nGive me just a minute..."
    puts "\n "
    state = GetParks.new(location)
    list_parks(state)
  end

  def list_parks(state)
    @parks_in_state = []
    puts "Here are all the National Parks in #{@location}."
    puts "\n"
      Park.all.each do |park|
        puts "#{park.list_number}. #{park.name} National Park"
        @parks_in_state << park.list_number
      end
    puts "\n"
    puts "Enter the number of the National Park you'd like more information about."
    while @selection != "exit"
      selection = gets.strip.upcase.to_i
        if @parks_in_state.include?(selection)
            selected = Park.find_by_number(selection)
            more_info(selected)
        else
            puts "Sorry, that number isn't an option. Please choose another."
        end
      end
    goodbye
  end

  def more_info(selected)  # List the parks by name and index + 1.
            puts "\n"
            puts "Good choice! Let's find out more about '#{selected.name} National Park'..."
            sleep(2)
            puts "\n"
            puts "#{selected.name} National Park"
            puts "\n"
            puts "#{selected.address}"
            puts "\n"
            puts "#{selected.description}"
            puts "\n"
            puts "For more information, visit #{selected.website}"
            sleep(5)
            options
  end

  def options
      puts "\n"
      puts "Would you like information about another park? (y/n)"
      case (gets.chomp)
      when 'y'
        list_parks(location)
      when 'n'
        puts "Would you like to find out about parks in another state?"
          case (gets.chomp)
            when 'y'
              Park.all.clear
              menu
            when 'n'
              goodbye
            else
              puts "Sorry, I don't understand please type 'y' for 'yes' or 'n' for 'no.'"
              options
          end
      else
        puts "Sorry, I don't understand please type 'y' for 'yes' or 'n' for 'no.'"
        options
      end
  end

  def goodbye
    puts "Awesome! Stay safe, and have fun on the trails."
  end

end
