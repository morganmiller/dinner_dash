require 'rails_helper'

feature 'user creates account' do
  before(:each) do
    @user = User.new(email: "what@whatwhat.com",
      password: "Seekrit",
      full_name: "Sir Whats",
      display_name: "mrwhatsalot")

    @user2 = User.new(email: "that@thatthat.com",
      password: "Soopur",
      full_name: "Miss Thats",
      display_name: "msthatsalot")

    visit root_path
  end

  scenario "user can find login page" do
    click_on "Sign up"

    expect(current_path).to eq(new_user_path)

    fill_in "Full Name", with: @user.full_name
    fill_in "Display Name", with: @user.display_name
    fill_in "Email", with: @user.email
    fill_in "Password", with: "Seekrit"

    click_button "Sign up"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "Welcome #{@user.display_name}!"
  end
end
