require 'rails_helper'

feature 'Logged in admin' do
  let(:category) { Category.create!(name: "Monster")}

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

  scenario 'can add new category' do
    click_on "Add new category"
    expect(current_path).to eq(new_admin_category_path)

    fill_in "Name", with: "Werewolf"

    click_on "Create category"
    expect(page).to have_content("Category successfully created!")

    visit items_path

    expect(page).to have_content("Werewolf")
  end

  scenario 'can view new category' do
    category = Category.create(name: "Werewolf")

    visit items_path

    expect(page).to have_content("Werewolf")

    visit admin_category_path(category)

    expect(page).to have_content("Category: Werewolf")
  end
end
