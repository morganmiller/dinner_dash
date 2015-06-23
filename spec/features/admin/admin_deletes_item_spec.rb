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

  scenario 'can delete an item' do
    within("#admin-items li:first-child") do
      click_on "Modify item"
    end

    click_on "Delete item"

    expect(current_path).to eq(admin_items_path)

    expect(page).to have_content "Item deleted successfully!"
    expect(page).to_not have_content "Eat Cheese and Die"
    expect(page).to_not have_content "The spookiest grilled cheese."
    expect(page).to_not have_content "$50.65"
  end
end
