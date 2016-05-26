class Bus < ActiveRecord::Base

  has_many :attendees, :through => :buses_attendees
  has_many :buses_attendees, dependent: :destroy

  has_one :event, :through => :buses_event
  has_one :buses_event, dependent: :destroy

  def available_seats
    self.seats_limit - attendees.size
  end

end
