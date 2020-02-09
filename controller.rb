require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/city.rb' )
require_relative( '../models/country.rb' )
also_reload( '../models/*' )

get '/countries' do
  @countries = Country.all
  erb(:index)
end

get '/countries/new' do
  @cities = House.all
  erb(:new)
end

post '/countries' do
  Country.new(params).save
  redirect to '/countries'
end

get '/countries/:id' do
  @country = Country.find(params['id'])
  erb(:show)
end

get '/countries/:id/edit' do
  @cities = House.all
  @country = Country.find(params['id'])
  erb(:edit)
end

post '/countries/:id' do
  country = Country.new(params)
  country.update
  redirect to "/countries/#{params['id']}"
end

post '/countries/:id/delete' do
  country = Country.find(params['id'])
  country.delete
  redirect to '/countries'
end
