class BusesAttendee < ActiveRecord::Base
  belongs_to :bus
  belongs_to :attendee
end
