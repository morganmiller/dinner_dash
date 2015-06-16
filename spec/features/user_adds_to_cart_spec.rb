require 'rails_helper'

feature 'add to cart' do
  before(:each) do
    @item = Item.create(title: "Eat Cheese and Die",
                description: "The spookiest grilled cheese.",
                price: 50.65)
    @item2 =  Item.create(title: "It Came From Beneath the Sink",
                description: "You don't want to know.",
                price: 200.99)
    visit root_path
  end

  scenario 'add first item to cart' do
    within("#items li:first-child") do
      click_on "View item"
    end

    expect(current_path).to eq(item_path(@item))

    click_on "Add to cart"
    expect(current_path).to eq(cart_items_path)
    expect(page).to have_content("Your Cart")
    expect(page).to have_content("Eat Cheese and Die")
    expect(page).to have_content("The spookiest grilled cheese.")
    expect(page).to have_content("$50.65")
  end

  # scenario 'add second item to cart' do
  #
  # end
end
