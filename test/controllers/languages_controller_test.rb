require 'test_helper'

class LanguagesControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get languages_update_url
    assert_response :success
  end

end
