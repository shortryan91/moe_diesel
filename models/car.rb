class Car < ActiveRecord::Base
  belongs_to :client
  has_many :bookings
end
