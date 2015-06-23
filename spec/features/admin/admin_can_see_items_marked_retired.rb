require 'rails_helper'

feature 'Logged in admin' do
  let(:category) { Category.create!(name: "Monster")}

  before(:each) do
    admin = User.create(email: "admin@example.com",
                         password: "password",
                         full_name: "jeff admin",
                         display_name: "admin",
                         role: 1)

    @item = Item.create(title: "Eat Cheese and Die",
                        description: "The spookiest grilled cheese.",
                        price: 50.65,
                        categories: [category],
                        retired: true)

    @item2 = Item.create(title: "Deep Trouble",
                        description: "Catch of the day!",
                        price: 40.95,
                        categories: [category],
                        retired: false)

    allow_any_instance_of(ApplicationController).to receive(:current_user) { admin }

    visit root_path
  end

  scenario 'can see retired items marked as retired' do
    expect(page).to have_content "Eat Cheese and Die"
    expect(page).to have_content "The spookiest grilled cheese."
    expect(page).to have_content "$50.65"
    expect(page).to have_content "Deep Trouble"
    expect(page).to have_content "RETIRED"
  end
end
