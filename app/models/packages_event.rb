class PackagesEvent < ActiveRecord::Base
  belongs_to :package
  belongs_to :event
end
