require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
  end

  test "admin only signup" do
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name:  "User",
                                         last_name: "Example",
                                         department: "営業",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    
  end
end