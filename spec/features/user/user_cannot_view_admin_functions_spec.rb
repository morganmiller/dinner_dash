require 'rails_helper'

feature 'Non-admin user' do
  before(:each) do
    @user = User.create(email: "user@example.com",
                         password: "password2",
                         full_name: "dave user",
                         display_name: "user",
                         role: 0)

    visit root_path
  end

  scenario 'tries to visit all items and sees 404 error message' do
    allow_any_instance_of(ApplicationController).to receive(:current_user) { @user }

    visit admin_items_path

    refute page.has_content?("All Items")
    assert page.has_content?("The page you were looking for doesn't exist.")
  end

  scenario 'tries to visit order dashboard and sees 404 error message' do
    allow_any_instance_of(ApplicationController).to receive(:current_user) { @user }

    visit admin_orders_path

    refute page.has_content?("Order Dashboard")
    assert page.has_content?("The page you were looking for doesn't exist.")
  end
end
