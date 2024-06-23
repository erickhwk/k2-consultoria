require "test_helper"

class LawFirmsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get law_firms_show_url
    assert_response :success
  end

  test "should get new" do
    get law_firms_new_url
    assert_response :success
  end

  test "should get create" do
    get law_firms_create_url
    assert_response :success
  end

  test "should get edit" do
    get law_firms_edit_url
    assert_response :success
  end

  test "should get update" do
    get law_firms_update_url
    assert_response :success
  end
end
