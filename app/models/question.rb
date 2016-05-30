class Question < ActiveRecord::Base

  has_many :answers, through: :questions_answers
  has_many :questions_answers, dependent: :destroy

  def self.generate_standard_questions(event)
    event_days_total = (event.to - event.from).to_i
    question_attend = Question.create(title: "Which days of the EXPO are you planning to attend")
    question_attend_lunch = Question.create(title: "Do you plan on attending our expo lunch?")
    event_days_total.times do |day|
      question_attend.answers << Answer.create(title: "Day #{day+1}")
      question_attend.answers << Answer.create(title: "Day #{day} & #{day+1}") if day > 0
      question_attend_lunch.answers << Answer.create(title: "Day #{day+1}")
      question_attend_lunch.answers << Answer.create(title: "Day #{day} & #{day+1}") if day > 0
    end
    question_attend_lunch.answers << Answer.create(title: "None (We will not be attending any luncheons)")

    question_coctail = Question.create(title: "Are you planning on attending the “Cocktail” Hour on Day 1 of the EXPO")
    question_coctail.answers << Answer.create(title: "Yes") << Answer.create(title: "No")

    question_attendees_specifications = Question.create(title: "Please specify any food allergies your attendees may have", text_field: true)

    event.questions << question_attend << question_attend_lunch << question_coctail << question_attendees_specifications
  end
end
