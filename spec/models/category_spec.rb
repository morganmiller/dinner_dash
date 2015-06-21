require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { Category.create!(name: "Vampire") }
  
  it "is valid" do
    expect(category).to be_valid
  end
  
  it "has a name" do
    expect(category.name).to eq("Vampire")
  end
  
  it "is invalid without name" do
    category.name = nil

    expect(category).to_not be_valid
  end
end
