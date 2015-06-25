require 'rails_helper'

feature 'Logged in admin' do
  let!(:category) { Category.create!(name: "Monster") }

  scenario 'can update orders' do
    @user = User.create!(email: "fml@database.sucks",
      password: "Seekrit",
      full_name: "Sir Whats",
      display_name: "mrwhatsalot")

    @admin = User.create!(email: "admin@example.com",
      password: "password",
      full_name: "jeff admin",
      display_name: "admin",
      role: 1)

    @item = Item.create!(title: "Eat Cheese and Die",
      description: "The spookiest grilled cheese.",
      price: 50.65,
      categories: [category])

    @item2 =  Item.create!(title: "It Came From Beneath the Sink",
      description: "You don't want to know.",
      price: 200.99,
      categories: [category])

    @order = Order.create!(user_id: @user.id,
      total_price: 50.65,
      items: [@item],
      created_at: "2015-06-11 19:35:07",
      updated_at: "2015-06-13 10:22:17",
      status: "ordered")

    @order2 = Order.create!(user_id: @user.id,
      total_price: 89.95,
      items: [@item, @item2],
      created_at: "2015-06-10 19:35:07",
      updated_at: "2015-06-12 10:22:17",
      status: "complete")

    @order3 = Order.create!(user_id: @user.id,
      total_price: 89.95,
      items: [@item, @item2],
      created_at: "2015-06-09 19:35:07",
      updated_at: "2015-06-23 10:22:17",
      status: "paid")

    @order4 = Order.create!(user_id: @user.id,
      total_price: 39.30,
      items: [@item2],
      created_at: "2015-04-22 19:35:07",
      updated_at: "2015-04-23 10:22:17",
      status: "cancelled")

    allow_any_instance_of(ApplicationController).to receive(:current_user) { @admin }

    visit root_path
    click_on "Order Dashboard"
    
    click_on "Mark as paid"
    
    expect(current_path).to eq(admin_orders_path)
    expect(page).to have_content("Your order has been updated!")
  end
  
end

