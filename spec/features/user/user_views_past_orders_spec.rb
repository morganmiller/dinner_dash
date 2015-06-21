require 'rails_helper'

feature "an authenticated user's recent order" do
  let(:category) { Category.create!(name: "Gross")}

  before(:each) do
    @item = Item.create(title: "Eat Cheese and Die",
      description: "The spookiest grilled cheese.",
      price: 50.65,
      categories: [category])
    @user = User.create(email: "what@whatwhat.com",
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

  feature "an authenticated user's past orders" do
    let(:category) { Category.create!(name: "Gross")}

    before(:each) do
      @item1 = Item.create(title: "Eat Cheese and Die",
                          description: "The spookiest grilled cheese.",
                          price: 50.65,
                          categories: [category])

      @item2 = Item.create(title: "It Came From Under the Sink",
                          description: "The spookiest grilled cheese.",
                          price: 10.10,
                          categories: [category])

      @user = User.create(email: "what@whatwhat.com",
                          password: "Seekrit",
                          full_name: "Sir Whats",
                          display_name: "mrwhatsalot")

      @order1 = Order.create(user_id: @user.id,
                             total_price: 50.65,
                             items: [@item1],
                             created_at: "2015-06-11 19:35:07")

      @order2 = Order.create(user_id: @user.id,
                            total_price: 10.10,
                            items: [@item2],
                            created_at: "2015-06-21 19:35:07")

      allow_any_instance_of(ApplicationController).to receive(:current_user) { @user }

      visit root_path
    end

    scenario 'will be displayed' do
      click_on "Order History"

      # order1_date = @order1.created_at.strftime("%m/%d/%y")
      # order2_date = @order2.created_at.strftime("%m/%d/%y")

      expect(current_path).to eq(orders_path)
      expect(page).to have_content("Your Orders")

      within("#orders li:first-child") do
        expect(page).to have_content("06/21/15")
      end

      within("#orders li:nth-child(2)") do
        expect(page).to have_content("06/11/15")
      end
    end
  end
end
