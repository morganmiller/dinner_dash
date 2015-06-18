require 'rails_helper'

feature 'user creates account' do
  before(:each) do
    @user1 = User.new(email: "what@whatwhat.com",
      password: "Seekrit",
      full_name: "Sir Whats",
      display_name: "mrwhatsalot")

    @user2 = User.new(email: "that@thatthat.com",
      password: "Soopur",
      full_name: "",
      display_name: "msthatsalot")

    visit root_path
  end

  scenario "user can create account" do
    click_on "Sign up"

    expect(current_path).to eq(new_user_path)
    
    fill_in "Full name", with: @user1.full_name
    fill_in "Display name", with: @user1.display_name
    fill_in "Email", with: @user1.email
    fill_in "Password", with: "Seekrit"

    click_button "Sign up"

    expect(current_path).to eq(root_path)
    expect(page).to have_content "Welcome #{@user1.display_name}!"
  end

  scenario "user can't create account with existing email" do
    User.create!(email: "what@whatwhat.com",
                 password: "Seekrit",
                 full_name: "Sir Whats",
                 display_name: "mrwhatsalot")
    
    expect(current_path).to eq(root_path)
    
    click_on "Sign up"

    expect(current_path).to eq(new_user_path)

    fill_in "Full name", with: "Sir Whats"
    fill_in "Display name", with: "mrwhatsalot"
    fill_in "Email", with: "what@whatwhat.com"
    fill_in "Password", with: "Seekrit"

    click_button "Sign up"

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content "Email has already been taken"
  end

  scenario "user can't create account without full name" do
    click_on "Sign up"

    expect(current_path).to eq(new_user_path)

    fill_in "Full name", with: @user2.full_name
    fill_in "Display name", with: @user2.display_name
    fill_in "Email", with: @user2.email
    fill_in "Password", with: "Soopur"

    click_button "Sign up"

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content ""
  end
end
