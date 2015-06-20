require 'rails_helper'

feature 'User logs in' do
  before(:each) do
    @user = User.create(email: "what@whatwhat.com",
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
    click_on "Login"

    expect(current_path).to eq(login_path)
  end

  scenario "registered user can login" do
    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in "Email", with: @user.email
    fill_in "Password", with: "Seekrit"

    click_button "Login"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "Welcome #{@user.display_name}!"
  end

  scenario "unregistered user can't login" do
    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in "Email", with: @user2.email
    fill_in "Password", with: "Soopur"

    click_button "Login"

    expect(current_path).to eq(login_path)
    expect(page).to have_content "Invalid Login"
  end
end
