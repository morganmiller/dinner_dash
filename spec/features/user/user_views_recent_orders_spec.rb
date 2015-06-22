require 'rails_helper'
require 'database_cleaner'

feature "an authenticated user's recent order" do
  let(:category) { Category.create!(name: "Gross")}

  before(:each) do
    @item = Item.create(title: "Eat Cheese and Die",
      description: "The spookiest grilled cheese.",
      price: 50.65,
      categories: [category])
    @user = User.create(email: "someone@else.new",
      password: "Seekrit",
      full_name: "Sir Whats",
      display_name: "mrwhatsalot")

    allow_any_instance_of(ApplicationController).to receive(:current_user) { @user }

    visit root_path

    within("#items li:nth-child(1)") do
      click_on "View item"
    end

    click_on "Add to cart"

    click_on "Checkout"
  end

  scenario 'will be displayed' do
    order = @user.orders.last

    expect(current_path).to eq(order_path(order))
    expect(page).to have_content("You have purchased 1 spooky item(s)")
    expect(page).to have_content("$50.65")
    expect(page).to have_content("Eat Cheese and Die")
  end

  scenario 'will show status' do
    order = @user.orders.last

    expect(current_path).to eq(order_path(order))
    expect(page).to have_content("Order Status: ordered")
  end
end
