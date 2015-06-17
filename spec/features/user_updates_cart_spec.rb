require 'rails_helper'

feature 'update cart' do

  before(:each) do
    @item = Item.create(title: "Eat Cheese and Die",
      description: "The spookiest grilled cheese.",
      price: 50.65)
    @item2 = Item.create(title: "It Came From Beneath the Sink",
      description: "You don't want to know.",
      price: 200.99)

    visit item_path(@item)
    click_on "Add to cart"
  end

  scenario 'change single item quantity' do
    fill_in "Quantity:", with: 2
    click_on "Update cart"

    expect(current_path).to eq(cart_path)

    expect(page).to have_content "Your cart has been updated! You now have 2 items in your cart."
  end

  scenario 'change multiple item quantities' do
    visit item_path(@item2)
    click_on "Add to cart"

    fill_in "Quantity:", :match => :first, with: 4

    click_on "Update cart"

    expect(current_path).to eq(cart_path)

    expect(page).to have_content "Your cart has been updated! You now have 41 items in your cart."
  end

end
