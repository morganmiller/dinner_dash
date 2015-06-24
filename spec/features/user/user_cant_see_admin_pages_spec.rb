require 'rails_helper'

feature 'Logged in user' do
  before(:each) do
    @user = User.create!(email: "fml@database.sucks",
      password: "Seekrit",
      full_name: "Sir Whats",
      display_name: "mrwhatsalot")

    @admin = User.create!(email: "admin@example.com",
      password: "password",
      full_name: "jeff admin",
      display_name: "admin",
      role: 1)
  end
  
  scenario "can't visit admin page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user) { @user }
    
    visit admin_items_path
    expect(page.status_code).to eq(403)
    
    visit new_admin_category_path
    expect(page.status_code).to eq(403)

    visit admin_orders_path
    expect(page.status_code).to eq(403)
  end
end
