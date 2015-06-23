require 'rails_helper'

feature 'user goes to other user page' do
  let(:category) { Category.create!(name: "Gross")}

  before(:each) do
    @user1 = User.create(email: "what@whatwhat.com",
                         password: "Seekrit",
                         full_name: "Sir Whats",
                         display_name: "mrwhatsalot")

    @user2 = User.new(email: "that@thatthat.com",
                      password: "Soopur",
                      full_name: "Miss Thats",
                      display_name: "msthatsalot")

    @item1 = Item.create!(title: "Eat Cheese and Die",
                          description: "The spookiest grilled cheese.",
                          price: 50.65,
                          categories: [category])

    @item2 = Item.create!(title: "It Came From Under the Sink",
                          description: "The spookiest grilled cheese.",
                          price: 10.10,
                          categories: [category])

    @order1 = Order.create!(user_id: @user2.id,
                            total_price: 50.65,
                            items: [@item1],
                            created_at: "2015-06-11 19:35:07",
                            updated_at: "2015-06-12 10:22:17",
                            status: "complete")
  end

  scenario 'and returns error' do
    allow_any_instance_of(ApplicationController).to receive(:current_user) { @user1 }

    visit order_path(@order1)
    # save_and_open_page
    expect(page.status_code).to eq(403)
  end


end
