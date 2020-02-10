require_relative('../models/country')
require_relative('../models/city')
require ('pry-byebug')

City.delete_all
Country.delete_all


country1 = Country.new({'name' => 'Thailand'})
country2 = Country.new({'name' => 'Mexico'})
country3 = Country.new({'name' => 'Croatia'})
country4 = Country.new({'name' => 'UAE'})
country5 = Country.new({'name' => 'Scotland'})

country1.save()
country2.save()
country3.save()
country4.save()
country5.save()

city1 = City.new({'country_id' => country1.id, 'name' => 'Bangkok'})
city2 = City.new({'country_id' => country2.id, 'name' => 'Cancun'})
city3 = City.new({'country_id' => country3.id, 'name' => 'Pula'})
city4 = City.new({'country_id' => country4.id, 'name' => 'Dubai'})
city5 = City.new({'country_id' => country5.id, 'name' => 'Edinburgh'})

city1.save()
city2.save()
city3.save()
city4.save()
city5.save()

binding.pry
nil
