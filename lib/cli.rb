require 'pry'

class User
attr_accessor :location, :state_name, :selection, :parks_in_state

  def call
    puts "\n"
    puts "***Welcome to the National Park System Directory!***"
    puts "\n"
    sleep(2)
    puts "With this app, you can find out about National Parks, Monuments, Historic Sites, and other \nNational Park Service (NPS) areas of interest in your state, or wherever your travels might take you."
    puts "\n"
    sleep(3)
    menu
  end

  def menu
    puts "Please enter the two-letter postal abbreviation for the state or territory \nwhose NPS sites you'd like to know about. Or, type 'exit' to exit the CLI."
      input = gets.strip.upcase.to_s
      while input != "EXIT"
      @location = input
        if @@states.include?(location)
          if @@states_no_parks.include?(location)
            puts "\n"
            puts "It may surprise you to learn that there aren't any National Park Service sites in that territory. \nWeird, right?"
            puts "\n"
            sleep(2)
            menu
          else
            name_conversion(location)
            get_parks(location)
          end
        else
          puts "Sorry, I didn't understand that."
          puts "\n"
          sleep(2)
          menu
        end
      end
      goodbye
  end

  def get_parks(location)
    puts "\n"
    puts "Great! Let's find out about all the National Park Service sites in #{@state_name}. \nRemember, some NPS sites span multiple states. Give me just a minute..."
    puts "\n "
    state = GetParks.new(location)
    list_parks(state)
  end

  def list_parks(state)
    @parks_in_state = []
    puts "Here are all the National Park Service sites in #{@state_name}:"
    puts "\n"
      Park.all.each do |park|
        puts "#{park.list_number}. #{park.name} #{park.designation}"
        @parks_in_state << park.list_number
      end
    puts "\n"
    puts "Enter the number of the National Park Service site you'd like more information about."
    while @selection != "exit"
      selection = gets.strip.upcase.to_i
        if @parks_in_state.include?(selection)
            selected = Park.find_by_number(selection)
            more_info(selected)
        else
            puts "Sorry, that isn't an option. Please choose one of the numbers above."
        end
      end
    goodbye
  end

  def more_info(selected)
            puts "\n"
            puts "Good choice! Let's find out more about #{selected.name} #{selected.designation}..."
            sleep(2)
            puts "\n"
            puts "#{selected.name} #{selected.designation}"
            puts "\n"
            puts "#{selected.address}"
            puts "\n"
            puts "#{selected.description}"
            puts "\n"
            puts "For more information, visit #{selected.website}."
            sleep(5)
            options
  end

  def options
      puts "\n"
      puts "Would you like information about another National Park Service site in #{@state_name}? (y/n)"
      case (gets.chomp)
      when 'y'
        list_parks(location)
      when 'n'
        puts "Would you like to find out about sites in another state or territory?"
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

  def name_conversion(location)
    @state_name = @@conversion.assoc(location)[1]
    @state_name
  end

  def goodbye
    puts "\n"
    puts "Awesome! Stay safe, and have fun out there."
    puts "\n"
    exit
  end

  @@states = ['AL', 'AK', 'AS', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FM', 'FL', 'GA', 'GU', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MH', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'MP', 'OH', 'OK', 'OR', 'PW', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VI', 'VA', 'WA', 'WV', 'WI', 'WY' ]
  @@states_no_parks = ['FM', 'MH', 'PW']
  @@conversion = {
      'AL' => 'Alabama',
      'AK' => 'Alaska',
      'AS' => 'America Samoa',
      'AZ' => 'Arizona',
      'AR' => 'Arkansas',
      'CA' => 'California',
      'CO' => 'Colorado',
      'CT' => 'Connecticut',
      'DE' => 'Delaware',
      'DC' => 'District of Columbia',
      'FM' => 'Federated States Of Micronesia',
      'FL' => 'Florida',
      'GA' => 'Georgia',
      'GU' => 'Guam',
      'HI' => 'Hawaii',
      'ID' => 'Idaho',
      'IL' => 'Illinois',
      'IN' => 'Indiana',
      'IA' => 'Iowa',
      'KS' => 'Kansas',
      'KY' => 'Kentucky',
      'LA' => 'Louisiana',
      'ME' => 'Maine',
      'MH' => 'Marshall Islands',
      'MD' => 'Maryland',
      'MA' => 'Massachusetts',
      'MI' => 'Michigan',
      'MN' => 'Minnesota',
      'MS' => 'Mississippi',
      'MO' => 'Missouri',
      'MT' => 'Montana',
      'NE' => 'Nebraska',
      'NV' => 'Nevada',
      'NH' => 'New Hampshire',
      'NJ' => 'New Jersey',
      'NM' => 'New Mexico',
      'NY' => 'New York',
      'NC' => 'North Carolina',
      'ND' => 'North Dakota',
      'OH' => 'Ohio',
      'OK' => 'Oklahoma',
      'OR' => 'Oregon',
      'PW' => 'Palau',
      'PA' => 'Pennsylvania',
      'PR' => 'Puerto Rico',
      'RI' => 'Rhode Island',
      'SC' => 'South Carolina',
      'SD' => 'South Dakota',
      'TN' => 'Tennessee',
      'TX' => 'Texas',
      'UT' => 'Utah',
      'VT' => 'Vermont',
      'VI' => 'Virgin Island',
      'VA' => 'Virginia',
      'WA' => 'Washington',
      'WV' => 'West Virginia',
      'WI' => 'Wisconsin',
      'WY' => 'Wyoming'
    }

end
