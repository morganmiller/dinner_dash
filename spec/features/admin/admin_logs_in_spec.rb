require 'rails_helper'

feature 'Admin logs in' do
  before(:each) do
    @admin = User.create(email: "admin@example.com",
                         password: "password",
                         full_name: "jeff admin",
                         display_name: "admin",
                         role: 1)

    visit root_path
  end

  scenario 'and can access functionality to modify items' do
    allow_any_instance_of(ApplicationController).to receive(:current_user) { @admin }

    visit admin_items_path
    assert page.has_content?("All Items")
  end

  scenario 'and can access order dashboard' do
    allow_any_instance_of(ApplicationController).to receive(:current_user) { @admin }

    visit admin_orders_path
    assert page.has_content?("Order Dashboard")
  end
end
