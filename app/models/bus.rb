class Bus < ActiveRecord::Base

  has_many :attendees, :through => :buses_attendees
  has_many :buses_attendees, dependent: :destroy
  accepts_nested_attributes_for :attendees, reject_if: :all_blank, allow_destroy: true

  has_one :event, :through => :buses_event
  has_one :buses_event, dependent: :destroy
  accepts_nested_attributes_for :event, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :buses_event, reject_if: :all_blank, allow_destroy: true

  def available_seats
    self.seats_limit - attendees.size
  end

  def attendees_companies
    attendees.map do |attendee|
      attendee.company
    end
  end

end
