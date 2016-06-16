class PaymentsController < ApplicationController
  before_action :find_company

  def credit_card
    @client_token = Braintree::ClientToken.generate
  end

  def validate
    is_test = Rails.configuration.PAYMENT_ENVIRONMENT == 'test'
    payment_method_nonce =  if is_test
                              'fake-valid-no-indicators-nonce'
                            else
                              params[:payment_method_nonce]
                            end
    payment_result = Braintree::Transaction.sale(
      amount: @company.subtotal,
      payment_method_nonce: payment_method_nonce
    )

    if payment_result.success?
      @company.update_attribute(:payment_status, :accepted)
    end

    redirect_to credit_card_payments_path(company_access_token: @company.access_token,
                                          success: payment_result.success?)
  end


private

  def find_company
    if params[:company_access_token].present? && Company.exists?(access_token: params[:company_access_token])
      @company = Company.find_by(access_token: params[:company_access_token])
    else
      redirect_to root_path
    end
  end

end
