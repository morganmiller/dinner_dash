# As an unauthenticated user,
# When I view my cart,
# I expect to see an option to adjust each item's quantity,
# When I change anything in my cart,
# I expect to be redirected to my updated cart view.

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
    
    expect(page).to have_content "Your cart has been updated"
  end
  
end


