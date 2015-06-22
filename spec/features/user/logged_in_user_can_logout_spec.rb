require 'rails_helper'

feature 'a user who is logged in' do
  before(:each) do
  @user = User.create(email: "what@whatwhat.com",
                      password: "Seekrit",
                      full_name: "Sir Whats",
                      display_name: "mrwhatsalot")
  visit root_path
  click_on "Login"

  fill_in "Email", with: @user.email
  fill_in "Password", with: "Seekrit"

  click_button "Login"
  end
  
  scenario 'can logout' do
    expect(page).to have_content("Logout")
    expect(page).to_not have_content("Login")

    click_on "Logout"
    
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Login")
    expect(page).to_not have_content("Logout")
  end
end
