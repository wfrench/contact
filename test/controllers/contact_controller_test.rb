require "test_helper"

class ContactControllerTest < ActionDispatch::IntegrationTest
  email = "user@example.com"
  name = "My Name"

  test "should post add" do
    get contact_add_url, params: { email: email, name: name }
    assert_response :success

    contact = Contact.find_by(email: email)
    assert contact
    assert_equal(contact.name, name)
    assert_equal(contact.email, email)
  end

  test "should post add - duplicate" do
    get contact_add_url, params: { name: "Test User", email: "me@there.com" }
    assert_response 422
  end

  test "should delete" do
    delete "/delete", params: { email: email }
    assert_response :success

    assert_not Contact.find_by(email: email)
  end

  test "should delete not found" do
    delete "/delete", params: { email: "notfound" }
    assert_response :success
  end

  test "should get search exact" do
    get "/search", params: { name: "Test User 2" }
    assert_response :success

    response_data = JSON.parse(response.body)["data"]
    assert_equal 1, response_data.size
    assert_equal "Test User 2", response_data.first["name"]
  end

  test "should get search partial match" do
    get "/search", params: { name: "Test User" }
    assert_response :success

    response_data = JSON.parse(response.body)["data"]
    assert_equal 2, response_data.size
  end

  test "should get search exact except for case" do
    get "/search", params: { name: "test user 2" }
    assert_response :success

    response_data = JSON.parse(response.body)["data"]
    assert_equal 1, response_data.size
    assert_equal "Test User 2", response_data.first["name"]
  end

  test "should get search no match" do
    get "/search", params: { name: "Non-Existant" }
    assert_response :success

    response_data = JSON.parse(response.body)["data"]
    assert_equal 0, response_data.size
  end
end
