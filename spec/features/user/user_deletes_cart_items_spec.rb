require 'rails_helper'

feature 'delete cart items' do
  let(:category) { Category.create!(name: "Gross")}

  before(:each) do
    @item = Item.create(title: "Eat Cheese and Die",
                        description: "The spookiest grilled cheese.",
                        price: 50.65,
                        categories: [category])
    @item2 =  Item.create(title: "It Came From Beneath the Sink",
                          description: "You don't want to know.",
                          price: 200.99,
                          categories: [category])

    visit item_path(@item)
    click_on "Add to cart"
  end

  scenario 'delete an item' do
    expect(page).to have_content "Eat Cheese and Die"
    click_on "Delete"

    expect(current_path).to eq(cart_path)

    expect(page).to_not have_content "Eat Cheese and Die"
  end
end
