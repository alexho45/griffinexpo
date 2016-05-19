class Attendee < ActiveRecord::Base
  belongs_to :company
  has_many :events
end
