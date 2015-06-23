require 'rails_helper'

feature 'Logged in admin' do
  let(:category) { Category.create!(name: "Gross")}

  before(:each) do
    admin = User.create(email: "admin@example.com",
                         password: "password",
                         full_name: "jeff admin",
                         display_name: "admin",
                         role: 1)

    @item = Item.create(title: "Eat Cheese and Die",
                        description: "The spookiest grilled cheese.",
                        price: 50.65,
                        categories: [category])
    @item2 = Item.create(title: "It Came From Beneath the Sink",
                         description: "You don't want to know.",
                         price: 200.99,
                         categories: [category])

    allow_any_instance_of(ApplicationController).to receive(:current_user) { admin }

    visit root_path
    click_on "Edit Items"
  end

  scenario 'can view item index' do
    expect(page).to have_content "All Items"
    expect(page).to have_content "Eat Cheese and Die"
    expect(page).to have_content "It Came From Beneath the Sink"
  end

  xscenario 'can view item details' do
    within("#admin-items li:first-child") do
      click_on "Modify item"
    end

    expect(current_path).to eq(edit_admin_item_path(@item))
  end

  xscenario 'can modify item details' do
    within("#admin-items li:first-child") do
      click_on "Modify item"
    end

    fill_in "Price", with: 67.95
    click_on "Update item"

    expect(current_path).to eq(item_path(@item))

    expect(page).to have_content "Item updated successfully!"
    expect(page).to have_content "$67.95"
    expect(page).to_not have_content "$50.65"
  end

  xscenario 'can modify retired status' do
    within("#admin-items li:first-child") do
      click_on "Modify item"
    end

    check "retired_box"
    click_on "Update item"

    visit items_path

    expect(page).to_not have_content "Eat Cheese and Die"
  end
end
