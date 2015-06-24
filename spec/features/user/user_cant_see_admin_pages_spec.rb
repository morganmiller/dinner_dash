require 'rails_helper'

feature 'When visiting admin pages' do
  before(:each) do
    @user = User.create!(email: "fml@database.sucks",
      password: "Seekrit",
      full_name: "Sir Whats",
      display_name: "mrwhatsalot")
  end
  
  scenario "a logged in user is forbidden" do
    allow_any_instance_of(ApplicationController).to receive(:current_user) { @user }
    
    visit admin_items_path
    expect(page.status_code).to eq(403)
    
    visit new_admin_category_path
    expect(page.status_code).to eq(403)

    visit admin_orders_path
    expect(page.status_code).to eq(403)
  end

  scenario "an unauthenticated user is forbidden" do
    visit admin_items_path
    expect(page.status_code).to eq(403)

    visit new_admin_category_path
    expect(page.status_code).to eq(403)

    visit admin_orders_path
    expect(page.status_code).to eq(403)
  end
end
