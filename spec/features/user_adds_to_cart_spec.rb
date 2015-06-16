require 'rails_helper'

feature 'add to cart' do
  before(:each) do
    Item.create(title: "Eat Cheese and Die",
                description: "The spookiest grilled cheese.",
                price: 50.65)
    Item.create(title: "It Came From Beneath the Sink",
                description: "You don't want to know.",
                price: 200.99)
    visit root_path
  end

  # scenario 'add first item to cart' do
  #   within("#items ul:first-child") do
  #     click_on "View item"
  #   end
  #   cart = Cart.new
  #
  #   expect(current_path).to eq(cart_items_path)
  #   assert page.has_content?("Eat Cheese and Die")
  # end

  # scenario 'add second item to cart' do
  #
  # end
end
