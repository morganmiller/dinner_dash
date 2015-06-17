require 'rails_helper'

feature 'browse items view' do
  before(:each) do
    @item = Item.create(title: "Eat Cheese and Die",
                description: "The spookiest grilled cheese.",
                price: 50.65)
    @item2 = Item.create(title: "It Came From Beneath the Sink",
                description: "You don't want to know.",
                price: 200.99)
    visit root_path
  end


  scenario 'view items index' do
    expect(page).to have_content "Eat Cheese and Die"
    expect(page).to have_content "The spookiest grilled cheese."
    expect(page).to have_content "$50.65"

    expect(page).to have_content "It Came From Beneath the Sink"
    expect(page).to have_content "You don't want to know."
    expect(page).to have_content "$200.99"
  end


  scenario 'view specific item' do
    within("#items li:first-child") do
      click_on "View item"
    end

    expect(current_path).to eq(item_path(@item))

    expect(page).to have_content "Eat Cheese and Die"
    expect(page).to have_content "The spookiest grilled cheese."
    expect(page).to have_content "$50.65"

    expect(page).to_not have_content "It Came From Beneath the Sink"
    expect(page).to_not have_content "You don't want to know."
    expect(page).to_not have_content "$200.99"
  end
end
