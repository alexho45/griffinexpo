class Answer < ActiveRecord::Base

  has_one :question, :through => :questions_answer
  has_one :questions_answer

end
