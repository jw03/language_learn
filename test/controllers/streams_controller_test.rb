require 'test_helper'

class StreamsControllerTest < ActionDispatch::IntegrationTest
  test "should get host" do
    get streams_host_url
    assert_response :success
  end

  test "should get join" do
    get streams_join_url
    assert_response :success
  end

end
