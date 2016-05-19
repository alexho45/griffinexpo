class BusesEvent < ActiveRecord::Base
  belongs_to :bus
  belongs_to :event
end
