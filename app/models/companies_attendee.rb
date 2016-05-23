class CompaniesAttendee < ActiveRecord::Base
  belongs_to :company
  belongs_to :attendee
end
