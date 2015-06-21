require 'rails_helper'

feature "an authenticated user's past orders" do
  before(:each) do
    @item = Item.create(title: "Eat Cheese and Die",
      description: "The spookiest grilled cheese.",
      price: 50.65)

    @user = User.create(email: "what@whatwhat.com",
      password: "Seekrit",
      full_name: "Sir Whats",
      display_name: "mrwhatsalot")

    visit root_path

    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in "Email", with: @user.email
    fill_in "Password", with: "Seekrit"

    click_button "Login"

    expect(current_path).to eq(root_path)


    within("#items li:nth-child(1)") do
      click_on "View item"
    end

    click_on "Add to cart"

    expect(current_path).to eq(cart_path)

    click_on "Checkout"

    expect(current_path).to eq(order_path(@order.id))
  end

  scenario 'will be displayed' do
    click_on "View past orders"

    expect(current_path).to eq(orders_path)
  end
end
