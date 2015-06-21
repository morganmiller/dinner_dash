require 'rails_helper'

feature 'User clicks checkout' do
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
    
    visit root_path

    within("#items li:nth-child(1)") do
      click_on "View item"
    end

    click_on "Add to cart"
  end

  scenario 'and can checkout if authorized' do
    allow_any_instance_of(ApplicationController).to receive(:current_user) { @user }

    click_on "Checkout"

    order = @user.orders.last
    expect(current_path).to eq(order_path(order))
    expect(page).to have_content "You have purchased 1 spooky item"
    expect(page).to have_content "Your Order"
  end
  
  scenario 'and cannot checkout if unauthorized' do
    click_on "Checkout"
    
    expect(current_path).to eq(login_path)
    expect(page).to have_content "You must log in or create an account to checkout!"
    expect(page).to have_content "Login"
  end
end
