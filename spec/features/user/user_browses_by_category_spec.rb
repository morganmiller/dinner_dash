require 'rails_helper'

feature 'any user is able to see' do
  before(:each) do
    @category = Category.create(name: "Ghost")
    @category2 = Category.create(name: "Monster")

    item1 = {
            title: "Eat Cheese and Die",
            description: "The spookiest grilled cheese.",
            price: 50.65
    }

    item2 = {
            title: "It Came From Beneath the Sink",
            description: "You don't want to know.",
            price: 200.99
    }

    item3 = {
            title: "Deep Trouble",
            description: "Catch of the day..",
            price: 65.90
    }

    @category.items.create(item1)
    @category2.items.create(item2)
    @category2.items.create(item3)

    visit root_path
  end

  scenario "one item associated with a category" do
    click_on "Ghost"

    expect(current_path).to eq(category_path(@category))

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
