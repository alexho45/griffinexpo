class CompaniesEvent < ActiveRecord::Base
  belongs_to :company
  belongs_to :event
end
