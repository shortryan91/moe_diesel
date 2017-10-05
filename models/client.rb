
class Client < ActiveRecord::Base
  has_secure_password
  has_many :cars
  has_many :bookings
end
