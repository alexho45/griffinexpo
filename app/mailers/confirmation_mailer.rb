# encoding: utf-8

class ConfirmationMailer < ActionMailer::Base
  default from: 'Support Team <exposupport@griffinmail.com>'

  def company_confirmation(company)
    @company = company
    mail(
      to:      @company.representative_email,
      subject: "Griffin EXPO successfull registration"
    )
  end

  def attendee_confirmation(attendee)
    @attendee = attendee
    @company = @attendee.company
    # @barcode_image = Barby::Code128B.new(@company.confirmation_token + @attendee.id.to_s).to_png
    # @barcode_image_raw = Base64.strict_encode64(@barcode_image)

    # attachments.inline['barcode.png'] = {
      # content: @barcode_image
    # }

    mail(
      to:      @attendee.email,
      subject: "Griffin EXPO successfull registration"
    )
  end
end
