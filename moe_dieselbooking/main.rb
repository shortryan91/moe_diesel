require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require_relative 'db_config'

require_relative 'models/car'
require_relative 'models/client'

enable :sessions

helpers do
  
    def current_user
      Client.find_by(id: session[:user_id])
    end

    def logged_in?
      if session[:user_id]
        # current_user can be used
        true
      else
        false
      end
    end

end

get '/' do
  erb :index
end

get '/contact' do
  erb :contact
end

get '/about' do
  erb :about
end


# adding your vehicle
get '/profile/add_car' do
  # @client = Client.find_by(id: params[:id])
  @client = current_user
  erb :add_car
end

post '/profile/:id' do
  @car = Car.new
  @car.make = params[:make]
  @car.year = params[:year]
  @car.registration = params[:registration]
  @car.save
  # find the client
  @client = Client.find_by(id: params[:id])
  # set client's cars_id to the newly created car's id
  @client.cars_id = @car.id
  @client.save
  redirect "/profile/#{params[:id]}"
end

# display profile page
get '/profile/:id' do
  @client = Client.find_by(id: params[:id])
  if @client.cars_id != nil
    # find the clients car using the cars_id
   @car = Car.find_by(id: @client.cars_id)
  end
  erb :profile
end


# login page
get '/login' do
  if (!current_user)
    erb :login
  else
    redirect '/profile'
  end
end

post '/session' do
 @client = Client.find_by(email: params[:email])
  if @client && @client.authenticate(params[:password])
    session[:user_id] = @client.id
    redirect "/profile/#{ @client.id }"
  else
   @message = 'incorrect email or password'
   erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/login'
end

# signing up for a account
get '/sign_up' do
  if session[:user_id] = nil
    erb :sign_up
  else

    redirect "/profile/#{params[:id]}"
  end
end

post '/sign_up' do
  client = Client.new
  client.name = params[:name]
  client.email = params[:email]
  client.phone_no = params[:phone_no]
  client.password = params[:password]
  client.save
  redirect '/'
end
