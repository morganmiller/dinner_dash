require 'rails_helper'

feature 'when an item is retired' do
  let(:category) { Category.create!(name: "Gross")}

  before(:each) do
    @item = Item.create(title: "Eat Cheese and Die",
                        description: "The spookiest grilled cheese.",
                        price: 50.65,
                        categories: [category],
                        retired: true)
    @user = User.new(email: "what@whatwhat.com",
                     password: "Seekrit",
                     full_name: "Sir Whats",
                     display_name: "mrwhatsalot")

    allow_any_instance_of(ApplicationController).to receive(:current_user) { @user }
  end

  scenario 'user can still visit item page' do
    visit item_path(@item)

    expect(page).to have_content "Eat Cheese and Die"
    expect(page).to have_content "The spookiest grilled cheese."
  end

  scenario 'a user cannot add item to cart' do
    visit item_path(@item)

    expect(page).to_not have_button "Add to cart"
  end
end
