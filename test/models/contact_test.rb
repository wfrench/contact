require "test_helper"

class ContactTest < ActiveSupport::TestCase
  email = "user@example.com"
  name = "My Name"

  test "Contact" do
    contact = Contact.new(name: name, email: email)
    assert contact.valid?
    contact.save
    assert_equal name, contact.reload.name
  end

  test "is not valid without a name" do
    contact = Contact.new(name: nil, email: email)
    assert_not contact.valid?
    assert_not contact.save
  end

  test "is not valid without an email" do
    contact = Contact.new(name: name, email: nil)
    assert_not contact.valid?
    assert_not contact.save
  end

  test "is not valid with a duplicate email" do
    contact1 = Contact.new(name: name, email: email)
    contact2 = Contact.new(name: name, email: email)

    assert contact1.save
    assert_not contact2.save
    assert_includes contact2.errors[:email], "has already been taken"
  end

  test "search by name" do
    contact = Contact.search("Jack Bauer")
    assert_equal 1, contact.count
    assert_equal contact.first.name, "Jack Bauer"
  end

  test "search by name - insensitive" do
    contact = Contact.search("jack bauer")
    assert_equal 1, contact.count
    assert_equal contact.first.name, "Jack Bauer"
  end

  test "search by name - fuzzy" do
    contact = Contact.search("jon")
    assert_equal 1, contact.count
    assert_equal contact.first.name, "John Doe"
  end

  test "search by email" do
    contact = Contact.search("24.com")
    assert_equal 1, contact.count
    assert_equal contact.first.email, "assassin@24.com"
  end

  test "search by email - insensitive" do
    contact = Contact.search("24.COM")
    assert_equal 1, contact.count
    assert_equal contact.first.email, "assassin@24.com"
  end

  test "search by email - fuzzy" do
    contact = Contact.search("exmaple.com")
    assert_equal 1, contact.count
    assert_equal contact.first.email, "example@example.com"
  end
end
