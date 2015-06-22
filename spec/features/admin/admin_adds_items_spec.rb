require 'rails_helper'

feature 'Logged in admin' do
  let(:category) { Category.create!(name: "Gross")}

  before(:each) do
    admin = User.create(email: "admin@example.com",
                         password: "password",
                         full_name: "jeff admin",
                         display_name: "admin",
                         role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user) { admin }

    visit root_path
    click_on "Edit Items"
  end

  xscenario 'can add new item' do
    click_on "Add new item"
    expect(current_path).to eq(new_admin_item_path)

    fill_in "Title", with: "Horrorland II"
    fill_in "Description", with: "Double scary"
    fill_in "Price", with: 59.95
    #add a category selection

    click_on "Create item"

    expect(page).to have_content "Item successfully created!"
    expect(page).to have_content "Horrorland II"

    click_on "Horrorland II"
    expect(page).to have_content "Ghost"
  end
end
