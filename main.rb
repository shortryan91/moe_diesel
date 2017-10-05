require 'sinatra'
# require 'sinatra/reloader'
require 'pry'
require_relative 'db_config'

require_relative 'models/car'
require_relative 'models/client'
require_relative 'models/booking'

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
 if logged_in?
  @client = current_user
  erb :add_car
 end
end

post '/profile' do
  if logged_in?
    @car = Car.new
    @car.make = params[:make]
    @car.year = params[:year]
    @car.registration = params[:registration]
    @car.client_id = params[:id]
    @car.save
    redirect "/profile"
  end
end

# display profile page
get '/profile' do
  if logged_in?

    @cars = Car.where(client_id: current_user.id)
    # @bookings = Booking.where(client_id: current_user.id)

    erb :profile
  end
end

# edit your car infomation
  get '/profile/edit' do
    if logged_in?
    @car = Car.find_by(client_id: current_user.id)
    erb :edit
   end
  end

  put '/profile' do
    @car = Car.find_by(client_id: current_user.id)
    if logged_in?
      @car.make = params[:make]
      @car.year = params[:year]
      @car.registration = params[:registration]
      @car.save
      redirect "/profile/#{current_user.id}"
    end
  end

# delete a car from your profile
delete '/cars/:id' do
  if logged_in?
  return 'go away' unless logged_in?
  @car = Car.find(params[:id])
  @car.destroy
  redirect "/profile"
 end
end

post '/booking/:id' do
  if logged_in?
  @booking = Booking.new
  @booking.client_id = params[:client_id]
  @booking.car_id = params[:car_id]
  @booking.date_booked = params[:date_booked]
  @booking.save
  redirect "/profile"
 end
end

delete '/booking/:id' do
  if logged_in?
    return 'go away' unless logged_in?
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect "/profile"
  end
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
    redirect "/profile"
  else
   @message = 'incorrect email or password'
   erb :login
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect '/login'
end

# signing up for an account
get '/sign_up' do
  if !current_user
    erb :sign_up
  else
    redirect "/profile"
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
