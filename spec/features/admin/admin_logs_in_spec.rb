require 'rails_helper'

feature 'Admin logs in' do
  before(:each) do
    admin = User.create(email: "admin@example.com",
                         password: "password",
                         full_name: "jeff admin",
                         display_name: "admin",
                         role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user) { admin }
    visit root_path
  end

  scenario 'and can access functionality to modify items' do
    expect(page).to have_content("Dashboard")
    expect(page).to have_content("Edit Items")
    expect(page).to have_content("Order Dashboard")
    expect(page).to have_content("Create Categories")

    click_on "Edit Items"

    expect(current_path).to eq(admin_items_path)

    expect(page).to have_content("All Items")
  end

  scenario 'and can access order dashboard' do
    click_on "Order Dashboard"

    expect(current_path).to eq(admin_orders_path)

    expect(page).to have_content("Order Dashboard")
  end

  scenario 'and can access functionality to create categories' do
    click_on "Create Categories"

    expect(current_path).to eq(admin_categories_path)
    expect(page).to have_content("All Categories")
  end
end
