require 'test_helper'

class BusinessesControllerTest < ActionController::TestCase
	fixtures :businesses

  test "should get index" do
    get :index
    assert_redirected_to root_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end
end
