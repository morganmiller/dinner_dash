require 'rails_helper'

feature 'a logged in user' do
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
  
  scenario 'cannot log in again' do
    visit login_path
    
    expect(page).to have_content "You're already logged in!"
    expect(page).to_not have_button "Login"
  end
end
