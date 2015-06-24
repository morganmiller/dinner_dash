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
  end

  scenario 'can view order dashboard' do
    expect(current_path).to eq(admin_orders_path)

    expect(page).to have_content "Total number of 'ordered' orders: 1"
    expect(page).to have_content "Total number of 'paid' orders: 1"
    expect(page).to have_content "Total number of 'cancelled' orders: 1"
    expect(page).to have_content "Total number of 'completed' orders: 1"

    expect(page).to have_content "Order created on 04/22/15"
    expect(page).to have_content "Order created on 06/09/15"
    expect(page).to have_content "Order created on 06/10/15"
    expect(page).to have_content "Order created on 06/11/15"

    expect(page).to have_content "Ordered"
    expect(page).to have_content "Paid"
    expect(page).to have_content "Cancelled"
    expect(page).to have_content "Complete"

    expect(page).to have_button "Cancel"
    expect(page).to have_button "Mark as paid"
    expect(page).to have_button "Mark as completed"
  end

  scenario 'can filter order dashboard' do
    click_on "Cancelled"
    save_and_open_page
    expect(page).to have_content "Order created on 04/22/15"
    expect(page).to_not have_content "Order created on 06/09/15"
    expect(page).to_not have_content "Order created on 06/10/15"
    expect(page).to_not have_content "Order created on 06/11/15"
  end
end
