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
    within("#items li:nth-child(1)") do
      click_on "View item"
    end

    expect(current_path).to eq(item_path(@item))

    click_on "Add to cart"
    expect(current_path).to eq(cart_path)
    expect(page).to have_content "Your Cart"
    expect(page).to have_content "Eat Cheese and Die"
    expect(page).to have_content "The spookiest grilled cheese."
    expect(page).to have_content "$50.65"
  end


  scenario 'add two items to cart' do
    within("#items li:first-child") do
      click_on "View item"
    end
    click_on "Add to cart"

    visit root_path

    within("#items li:nth-child(2)") do
      click_on "View item"
    end
    click_on "Add to cart"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content "Your Cart"
    expect(page).to have_content "Eat Cheese and Die"
    expect(page).to have_content "The spookiest grilled cheese."
    expect(page).to have_content "$50.65"

    expect(page).to have_content "It Came From Beneath the Sink"
    expect(page).to have_content "You don't want to know."
    expect(page).to have_content "$200.99"
  end
end
