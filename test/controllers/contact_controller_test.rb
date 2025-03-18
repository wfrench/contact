require "test_helper"

class ContactControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get contact_add_url
    assert_response :success
  end

  test "should get delete" do
    get contact_delete_url
    assert_response :success
  end

  test "should get search" do
    get contact_search_url
    assert_response :success
  end
end
