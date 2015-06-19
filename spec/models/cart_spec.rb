require 'rails_helper'

RSpec.describe Cart, type: :model do
  
  before(:each) do
    @item1 = Item.create(title: "Eat Cheese and Die",
                         description: "The spookiest grilled cheese.",
                         price: 50.65)
    @item2 = Item.create(title: "It Came From Beneath the Sink",
                         description: "You don't want to know.",
                         price: 200.99)
    @initial_contents = {"1" => "3", "2" => "1", "3" => "5"}
  end
  
  
  it "takes contents of items and their quantities" do
    cart = Cart.new(@initial_contents)
    
    expect(cart.contents).to eq(@initial_contents)
  end

  it "adds items to contents by item id" do
    cart = Cart.new(@initial_contents)
    cart.add_item(4)
    
    expect(cart.contents.keys).to include "4"
    expect(cart.contents["4"]).to eq 1
  end
  
  it "knows the items in its cart" do
    cart = Cart.new({})
    cart.add_item(@item1.id)
    cart.add_item(@item2.id)
    cart_item1 = cart.items.keys.first
    cart_item2 = cart.items.keys.last
    
    expect(cart_item1).to be_a(Item)
    expect(cart_item1.title).to eq("Eat Cheese and Die")
    expect(cart_item2.description).to eq("You don't want to know.")
  end
  
  it "knows how many items in its cart" do
    cart = Cart.new(@initial_contents)
    
    expect(cart.items_total).to eq(9)
  end
  
  it "can remove items from its cart" do
    cart = Cart.new(@initial_contents)
    expect(cart.contents.keys.count).to eq(3)
    
    cart.delete_item("1")
    expect(cart.contents.keys.count).to eq(2)
  end
  
  it "knows the total price of the items in its cart" do
    cart = Cart.new({})
    cart.add_item(@item1.id)
    cart.add_item(@item2.id)
    
    expect(cart.total_price).to eq(251.64)
  end
end















