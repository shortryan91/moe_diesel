class Booking < ActiveRecord::Base
  belongs_to :client
  belongs_to :car
end
