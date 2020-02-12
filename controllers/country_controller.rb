require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative( '../models/country.rb' )
require_relative( '../models/city.rb' )
also_reload( '../models/*' )

get '/countries' do
  @countries = Country.all
  erb(:"countries/index")
end

get '/countries/new' do
  @countries = Country.all
  erb(:"countries/new")
end

post '/countries' do
  Country.new(params).save
  redirect to '/countries'
end

get '/countries/wishlist' do
  @countries = Country.wishlist()
  erb(:"countries/index")
end

get '/countries/visited' do
  @countries = Country.visited()
  erb(:"countries/index")
end

get '/countries/:id' do
  @country = Country.find(params['id'])
  erb(:"countries/show")
end

get '/countries/:id/edit' do
  @country = Country.find(params['id'])
  erb(:"countries/edit")
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

get '/countries/:id/edit' do
  id = params[:id].to_i()
  @country = Country.find(id)
  erb(:"countries/edit")
end

post '/countries/:id/update' do
  country = Country.new(params)
  country.update()
  redirect '/countries'
end
