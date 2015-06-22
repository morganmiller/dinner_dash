require 'rails_helper'

RSpec.describe Item, type: :model do

  let(:category) {
                   Category.create!(name: "Vampire")
   }

  let(:item) {
                   Item.create!(title: "Monster Blood",
                                description: "A red, sticky treat.",
                                price: 15.50,
                                categories: [category])
   }

  it "is valid" do
    expect(item).to be_valid
  end

  it "has valid attributes" do
    expect(item.title).to eq("Monster Blood")
    expect(item.description).to eq("A red, sticky treat.")
    expect(item.price).to eq(15.50)
    expect(item.categories.first).to eq(category)
  end

  it "is invalid without a title" do
    item.title = ""

    expect(item).to_not be_valid
  end

  it "is invalid without a description" do
    item.description = ""

    expect(item).to_not be_valid
  end

  it "is invalid without a price" do
    item.price = nil

    expect(item).to_not be_valid
  end

  it "must have decimal price greater than 0" do
    item.price = 0

    expect(item.price).to be_a(BigDecimal)
    expect(item).to_not be_valid
  end

  it "must have a unique name" do
    item

    expect { Item.create!(title: "Monster Blood",
                          description: "Another red, sticky treat.",
                          price: 20.00,
                          categories: [category])
           }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "must belong to one category minimum" do
    item.categories = []

    expect(item).to_not be_valid
  end

  it "is not retired by default" do
    expect(item.retired?).to be_falsey
  end
end
