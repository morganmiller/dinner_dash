require 'rails_helper'

RSpec.describe Cart, type: :model do
  
  it "takes contents of items and their quantities" do
    initial_contents = {"1" => "3", "2" => "1", "3" => "5"}
    cart = Cart.new(initial_contents)
    expect(cart.contents).to eq(initial_contents)
  end

  
end
