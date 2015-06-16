# As an unauthenticated user...
#When I visit the home page...
#Then I expect to see a list of available spooky items (root to items_path)

require 'rails_helper'

feature 'browse items view' do
  before(:each) do
    Item.create(title: "Eat Cheese and Die",
                description: "The spookiest grilled cheese.",
                price: 50.65)
    Item.create(title: "It Came From Beneath the Sink",
                description: "You don't want to know.",
                price: 200.99)
    visit root_path
  end

  scenario 'view items' do
      expect(page).to have_content "Eat Cheese and Die"
      expect(page).to have_content "The spookiest grilled cheese."
      expect(page).to have_content "$50.65"
      
      expect(page).to have_content "It Came From Beneath the Sink"
      expect(page).to have_content "You don't want to know."
      expect(page).to have_content "$200.99"
  end
end

