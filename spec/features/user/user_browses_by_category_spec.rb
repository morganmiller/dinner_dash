require 'rails_helper'

feature 'any user is able to see' do

  let(:category) { Category.create!(name: "Ghost")}
  let(:category2) { Category.create!(name: "Monster")}

  before(:each) do
    @item = Item.create(title: "Eat Cheese and Die",
                        description: "The spookiest grilled cheese.",
                        price: 50.65,
                        categories: [category])
    @item2 =  Item.create(title: "It Came From Beneath the Sink",
                          description: "You don't want to know.",
                          price: 200.99,
                          categories: [category2])
    @item3 = Item.create(title: "Deep Trouble",
                         description: "Catch of the day..",
                         price: 65.90,
                         categories: [category2])

    visit root_path
  end
  
  scenario "one item associated with a category" do
    click_on "Ghost"

    expect(current_path).to eq(category_path(category))

    expect(page).to have_content("Eat Cheese and Die")
    expect(page).to_not have_content("It Came From Beneath the Sink")
  end

  scenario "multiple items associated with a category" do
    click_on "Monster"

    expect(page).to have_content("It Came From Beneath the Sink")
    expect(page).to have_content("Deep Trouble")
    expect(page).to_not have_content("Eat Cheese and Die")
  end
end
