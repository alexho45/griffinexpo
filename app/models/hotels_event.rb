class HotelsEvent < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :event
  belongs_to :company
end
