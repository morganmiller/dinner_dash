require 'rails_helper'

feature 'User Logs In' do
  before(:each) do
    @user = User.create(email: "what@whatwhat.com",
                        password: "Seekrit",
                        full_name: "Sir Whats",
                        display_name: "mrwhatsalot")

    @user2 = User.create(email: "that@thatthat.com",
                        password: "Soopur",
                        full_name: "Miss Thats",
                        display_name: "msthatsalot")

    visit root_path
  end

  scenario "user can find login page" do
    click_on "Login"

    expect(current_path).to eq(login_path)
  end

  scenario "user can fill out login info" do
    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in "Email", with: @user.email
    fill_in "Password", with: "Seekrit"

    click_button "Login"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "Welcome #{@user.display_name}!"
  end

end
