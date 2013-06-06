require 'test_helper'

class Auth::StepTwoControllerTest < ActionController::TestCase
  test "should get confirmation" do
    get :confirmation
    assert_response :success
  end

end
