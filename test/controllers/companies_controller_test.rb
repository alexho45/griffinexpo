require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post :create, company: { access_token: @company.access_token, address: @company.address, company_type: @company.company_type, confirmation_token: @company.confirmation_token, name: @company.name, payment_status: @company.payment_status, payment_type: @company.payment_type, process_step: @company.process_step, registrant: @company.registrant, representative_email: @company.representative_email, representative_phone: @company.representative_phone }
    end

    assert_redirected_to company_path(assigns(:company))
  end

  test "should show company" do
    get :show, id: @company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company
    assert_response :success
  end

  test "should update company" do
    patch :update, id: @company, company: { access_token: @company.access_token, address: @company.address, company_type: @company.company_type, confirmation_token: @company.confirmation_token, name: @company.name, payment_status: @company.payment_status, payment_type: @company.payment_type, process_step: @company.process_step, registrant: @company.registrant, representative_email: @company.representative_email, representative_phone: @company.representative_phone }
    assert_redirected_to company_path(assigns(:company))
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete :destroy, id: @company
    end

    assert_redirected_to companies_path
  end
end
