require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/city.rb' )
require_relative( '../models/city.rb' )
also_reload( '../models/*' )

get '/cities' do
  @cities = City.all
  erb(:"/cities/index")
end

get '/cities/new' do
  erb(:"cities/new")
end

post '/cities' do
  City.new(params).save
  redirect to '/cities'
end

get '/cities/:id' do
  @city = City.find(params['id'])
  erb(:"cities/show")
end

get '/cities/:id/edit' do
  @city = City.find(params['id'])
  @country_id = @city.country_id
  erb(:"cities/edit")
end

post '/cities/:id' do
  city = City.new(params)
  city.update
  redirect to "/countries/#{params['id']}"
end

post '/cities/:id/delete' do
  city = City.find(params['id'])
  city.delete
  redirect to '/countries'
end
