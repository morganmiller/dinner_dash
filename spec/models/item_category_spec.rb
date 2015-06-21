require 'rails_helper'

RSpec.describe ItemCategory, type: :model do
  let(:category) {
    Category.create!(name: "Vampire")
  }

  let(:category2) {
    Category.create!(name: "Ghost")
  }
  
  let(:item_data) {
                    {title: "Monster Blood",
                     description: "A red, sticky treat.",
                     price: 15.50}
  }

  let(:more_item_data) {
                          {title: "Let's Get Invisible!",
                            description: "An empty plate.",
                            price: 100.00}
  }
  
  it "can associate items with categories" do
    item = Item.new(item_data)
    item.categories << category
    item.save!
    
    expect(item.categories).to eq([category])
    expect(category.items).to eq([item])
  end
  
  it "can associate many items with one category" do
    item = Item.new(item_data)
    item2 = Item.new(more_item_data)
    item.categories << category
    item.save!
    item2.categories << category
    item2.save!
    
    expect(category.items.count).to eq(2)
    expect(item.categories.first.name).to eq ("Vampire")
    expect(category.items.first.title).to eq("Monster Blood")
    expect(category.items.last.title).to eq("Let's Get Invisible!")
  end
  
  it "can associate many categories with one item" do
    item = Item.new(item_data)
    item.categories << category
    item.categories << category2
    item.save!
    
    expect(item.categories.count).to eq(2)
    expect(item.categories.first.name).to eq("Vampire")
    expect(item.categories.last.name).to eq("Ghost")
  end
  
end
