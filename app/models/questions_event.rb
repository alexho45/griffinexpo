class QuestionsEvent < ActiveRecord::Base
  belongs_to :question
  belongs_to :event
end
