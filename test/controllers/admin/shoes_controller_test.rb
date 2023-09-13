require "test_helper"

class Admin::ShoesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_shoes_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_shoes_show_url
    assert_response :success
  end
end
