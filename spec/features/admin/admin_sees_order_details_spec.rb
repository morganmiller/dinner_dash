require 'rails_helper'

feature 'Logged in admin' do
  let(:category) { Category.create!(name: "Monster") }

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

    allow_any_instance_of(ApplicationController).to receive(:current_user) { @user }

    @item = Item.create!(title: "Eat Cheese and Die",
                         description: "The spookiest grilled cheese.",
                         price: 50.65,
                         categories: [category])

    @item2 =  Item.create!(title: "It Came From Beneath the Sink",
                           description: "You don't want to know.",
                           price: 200.99,
                           categories: [category])

    visit root_path
    within("#items li:nth-child(1)") do
      click_on "View item"
    end

    click_on "Add to cart"
    click_on "Checkout"

    allow_any_instance_of(ApplicationController).to receive(:current_user) { @admin }
    visit admin_root_path
    click_on "Order Dashboard"
  end

  scenario 'can view specific order details' do
    click_on "Order created on 06/25/15"

    expect(page).to have_content "Order date/time"
    expect(page).to have_content "Purchaser name: Sir Whats"
    expect(page).to have_content "Purchaser email: fml@database.sucks"

    expect(page).to have_content "Item: Eat Cheese and Die"
    expect(page).to have_content "Price: $50.65"
    expect(page).to have_content "Quantity: 1"
    expect(page).to have_content "Item subtotal: $50.65"

    expect(page).to have_content "Order total: $50.65"
    expect(page).to have_content "Order status: ordered"
  end

  scenario 'can view item page through order details' do
    click_on "Order created on 06/25/15"
    click_on "Eat Cheese and Die"

    expect(current_path).to eq(admin_item_path(@item.id))
  end
end
