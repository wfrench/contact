require "test_helper"

class ContactControllerTest < ActionDispatch::IntegrationTest
  email = "user@example.com"
  name = "My Name"

  test "should post add" do
    post "/add", params: { email: email, name: name }
    assert_response :success

    contact = Contact.find_by(email: email)
    assert contact
    assert_equal(contact.name, name)
    assert_equal(contact.email, email)
  end

  test "should post add - duplicate" do
    post "/add", params: { name: "Jack Bauer", email: "assassin@24.com" }
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

  test "should get search" do
    get "/search", params: { name: "Jack Bauer" }
    assert_response :success

    response_data = JSON.parse(response.body)["data"]
    assert_equal 1, response_data.size
    assert_equal "Jack Bauer", response_data.first["name"]
  end

  test "should get search no match" do
    get "/search", params: { name: "Non-Existant" }
    assert_response :success

    response_data = JSON.parse(response.body)["data"]
    assert_equal 0, response_data.size
  end
end
