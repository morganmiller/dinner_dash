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
    # save_and_open_page
    # page.check("retired")

    within("#category-checkboxes li:first-child") do
      page.check("item[category_ids]['1']")
    end

    # //*[@id="item_category_ids_1"]

    # find(:css, "#item_category_ids_1").set(true)

    click_on "Create item"

    expect(page).to have_content "Item successfully created!"
    expect(page).to have_content "Horrorland II"
    expect(page).to have_content "Double scary"
    expect(page).to have_content "$59.95"
    expect(page).to have_content "Monster"
  end

  scenario 'cannot add new item without a category' do
    click_on "Add new item"
    expect(current_path).to eq(new_admin_item_path)

    fill_in "Title", with: "Horrorland II"
    fill_in "Description", with: "Double scary"
    fill_in "Price", with: 59.95

    click_on "Create item"

    expect(page).to have_content "Items needs at least one category!"
    expect(page).to have_content "Create New Item"
  end
end
