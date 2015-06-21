require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { 
               User.create!(full_name: "R.L. Stine",
                            display_name: "Stiner",
                            email: "goosebumps@rscary.com",
                            password: "aaah")
  }
  
  let(:category) { Category.create!(name: "Vampire") }

  let(:item) {
               Item.create!(title: "Monster Blood",
                            description: "A red, sticky treat.",
                            price: 15.50,
                            categories: [category])
  }
  
  let(:order) { 
                Order.new(total_price: 500.00,
                          user_id: user.id)
  }
  
  before(:each) do
    order.items << item
    order.save!
  end
  
  it "is valid" do
    expect(order).to be_valid  
  end
  
  it "has valid attributes" do
    expect(order.total_price).to eq(500.00)
  end
  
  it "belongs to a user" do
    expect(order.user).to eq(user)
  end

  it "has default status of ordered" do
    expect(order.status).to eq("ordered")
  end
  
  it "receives only valid statuses" do
    order.status = "paid"
    expect(order).to be_valid

    order.status = "cancelled"
    expect(order).to be_valid

    order.status = "complete"
    expect(order).to be_valid
    
    order.status = "pending"
    expect(order).to_not be_valid
  end
  
  it "has at least one item" do
    expect(order.items.count).to eq(1)
  end
  
  it "is invalid without items" do
    order.items = []
    expect(order).to_not be_valid
  end
end
