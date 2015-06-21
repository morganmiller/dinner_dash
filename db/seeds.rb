class Seed
  def self.start
    new.generate
  end

  def generate
    create_users
    create_categories
    create_items
  end

  def create_users
    users.each do |full_name, display_name, email, password, role|
      User.create full_name: full_name, display_name: display_name, email: email, password: password, role: role
    end
    puts "Users: #{User.all.map(&:full_name).join(", ")} created."
  end


  def create_categories
    categories.each do |name|
      Category.create(name: name)
    end
    puts "Category: #{Category.all.map(&:name).join(", ")} created."
  end

  def create_items
    items.each do |title, description, price, categories|
      Item.create(title: title, description: description, price: price, categories: categories)
    end
    puts "Items: #{Item.all.map(&:title).join(", ")} created."
  end

  def create_orders
    orders.each do |user_id, status, total_price|
      Order.create(user_id: user_id, status: status, total_price: total_price)
    end
    puts "Orders: #{Order.all.map(&:user_id).join(", ")} created."
  end

  private

  def users
    [
      ["Jeff Casimir", "j3", "demo+jeff@jumpstartlab.com", "password", 0],
      ["Jorge Tellez", "novohispano", "demo+jorge@jumpstartlab.com", "password", 0],
      ["Josh Cheek", "josh", "demo+josh@jumpstartlab.com", "password", 1],
      ["Rachel Warbelow","", "demo+rachel@jumpstartlab.com", "password", 0],
    ]
  end

  def orders
    [
      [1, "ordered", 1200],
      [2, "completed", 2200],
      [3, "cancelled", 400],
      [3, "paid", 10300],
      [4, "ordered", 2000],
      [4, "ordered", 800],
      [2, "completed", 1001],
      [1, "ordered", 2003],
      [3, "cancelled", 300],
      [1, "paid", 3000],
    ]
  end

  def categories
    [ "Vampire", "Werewolf", "Zombie", "Ghost", "Other" ]
  end

  def items
    [
      ["Eat Cheese & Die", "The ooziest grilled cheese", 50.00, [Category.find(1)]],
      ["Welcome to Dead House",  "Spooky Spooky Spooky", 50.00, [Category.find(1), Category.find(2)]],
      ["Monster Blood", "Spooky Spooky Spooky", 50.00, [Category.find(1)]],
      # ["Let's Get Invisible", "Spooky Spooky Spooky", 50.00],
      # ["The Ghost Next Door", "Spooky Spooky Spooky", 50.00],
      # ["The Haunted Mask", "Spooky Spooky Spooky", 50.00],
      # ["Deep Trouble", "Spooky Spooky Spooky", 50.00],
      # ["Go Eat Worms", "Spooky Spooky Spooky", 50.00],
      # ["Ghost Beach", "Spooky Spooky Spooky", 50.00],
      # ["Attack of the Mutant", "Spooky Spooky Spooky", 50.00],
      # ["The Barking Ghost", "Spooky Spooky Spooky", 50.00],
      # ["Tick Tock You're Dead", "Spooky Spooky Spooky", 50.00],
      # ["Bad Hare Day", "Spooky Spooky Spooky", 50.00],
      # ["The Coo Coo Cloock of Doom", "Spooky Spooky Spooky", 50.00],
      # ["My Hairiest Adventure", "Spooky Spooky Spooky", 50.00],
      # ["The Return of the Mummy", "Spooky Spooky Spooky", 50.00],
      # ["Why I am Afraid of Bees", "Spooky Spooky Spooky", 50.00],
      # ["You Can't Scare Me", "Spooky Spooky Spooky", 50.00],
      # ["The Girl Who Cried Monster", "Spooky Spooky Spooky", 50.00],
      # ["Stay Out Of the Basement", "Spooky Spooky Spooky", 50.00],
    ]
  end
end

Seed.start
