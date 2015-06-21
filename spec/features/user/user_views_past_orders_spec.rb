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

feature "an authenticated user's past orders" do
  let(:category) { Category.create!(name: "Gross")}

  before(:each) do
    @item1 = Item.create!(title: "Eat Cheese and Die",
      description: "The spookiest grilled cheese.",
      price: 50.65,
      categories: [category])

    @item2 = Item.create!(title: "It Came From Under the Sink",
      description: "The spookiest grilled cheese.",
      price: 10.10,
      categories: [category])

    @user = User.create!(email: "fml@database.sucks",
      password: "Seekrit",
      full_name: "Sir Whats",
      display_name: "mrwhatsalot")

    @order1 = Order.create!(user_id: @user.id,
      total_price: 50.65,
      items: [@item1],
      created_at: "2015-06-11 19:35:07",
      updated_at: "2015-06-12 10:22:17",
      status: "complete")

    @order2 = Order.create!(user_id: @user.id,
      total_price: 10.10,
      items: [@item2],
      created_at: "2015-06-21 19:35:07")

    allow_any_instance_of(ApplicationController).to receive(:current_user) { @user }

    visit root_path
  end

  scenario 'will be displayed' do
    click_on "Order History"

    expect(current_path).to eq(orders_path)
    expect(page).to have_content("Your Orders")

    within("#orders li:first-child") do
      expect(page).to have_content("06/21/15")
    end

    within("#orders li:nth-child(2)") do
      expect(page).to have_content("06/11/15")
    end
  end

  scenario 'can link to individual orders' do
    click_on "Order History"

    within("#orders li:first-child") do
      click_on "Order created on 06/21/15"
    end

    expect(current_path).to eq(order_path(@order2))
  end

  scenario 'link to each item in the order' do
    click_on "Order History"

    within("#orders li:first-child") do
      click_on "Order created on 06/21/15"
    end

    click_on "It Came From Under the Sink"

    expect(current_path).to eq(item_path(@item2))
    expect(page).to have_content("The spookiest grilled cheese.")
  end
  
  scenario 'shows completed or cancelled times' do
    click_on "Order History"

    within("#orders li:nth-child(2)") do
      click_on "Order created on 06/11/15"
    end
    
    expect(page).to have_content("Order marked as complete at 10:22 on 06/12/15")
  end

  scenario 'shows date order was placed' do
    click_on "Order History"

    within("#orders li:nth-child(2)") do
      click_on "Order created on 06/11/15"
    end

    expect(page).to have_content("Order placed on 06/11/15 at 19:35")
  end
end
