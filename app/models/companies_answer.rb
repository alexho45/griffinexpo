class CompaniesAnswer < ActiveRecord::Base
  belongs_to :company
  belongs_to :answer
  belongs_to :question
end
