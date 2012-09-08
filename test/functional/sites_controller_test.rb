require 'test_helper'

class SitesControllerTest < ActionController::TestCase
  test "should get list" do
    get :list
    assert_response :success
  end

  test "should get visit" do
    get :visit
    assert_response :success
  end

end
