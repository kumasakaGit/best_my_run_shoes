require "test_helper"

class RanksControllerTest < ActionDispatch::IntegrationTest
  test "should get rank" do
    get ranks_rank_url
    assert_response :success
  end
end
