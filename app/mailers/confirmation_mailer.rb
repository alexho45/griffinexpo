# encoding: utf-8

class ConfirmationMailer < ActionMailer::Base
  default from: 'Support Team <exposupport@griffinmail.com>'
  helper CompaniesHelper

  def company_confirmation(company)
    @company = company
    mail(
      to:      @company.representative_email,
      subject: "Griffin EXPO successful registration"
    )
  end

  def attendee_confirmation(attendee)
    @attendee = attendee
    @company = @attendee.company

    mail(
      to:      @attendee.email,
      subject: "Griffin EXPO successfull registration"
    )
  end
end
