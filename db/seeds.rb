class Seed
  def self.start
    new.generate
  end

  def generate
    create_users
    create_items
    create_categories
  end

  def create_users
    users.each do |full_name, email, password, role, display_name|
      User.create fullname: full_name, email: email, password: password, role: role, display_name: display_name
    end
    puts "Users: #{User.all.map(&:fullname).join(", ")} created."
  end


  def create_categories
    categories.each do |name|
      Category.create(name: name)
    end
    puts "Category: #{Category.all.map(&:name).join(", ")} created."
  end

  def create_items
    item.each do |title, description, price|
      category = Category.find_by(id)
      category.items.create(title: title, description: description, price: price)
    end
    puts "Items: #{Item.all.map(&:title).join(", ")} created."
  end

  # def create_orders
  #   orders.each do |user_id, status, total|
  #     Order.create(user_id: user_id, status: status, total: total)
  #   end
  #   puts "Orders: #{Order.all.map(&:user_id).join(", ")} created."
  # end

  def users
    [
      [User.create id: 1, full_name: "Rachel Warbelow", display_name: 50.00, email: "demo+rachel@jumpstartlab.com", password: "password", role: 0]
      [User.create id: 2, full_name: "Jeff Casimir", display_name: "j3", email: "demo+jeff@jumpstartlab.com", password: "password", role: 0]
      [User.create id: 3, full_name: "Jorge Tellez", display_name: "novohispano", email: "demo+jorge@jumpstartlab.com", password: "password", role: 0]
      [User.create id: 4, full_name: "Josh Cheek", display_name: "josh", email: "demo+josh@jumpstartlab.com", password: "password", role: 1]
    ]
  end

  def categories
    [
      [Category.create id: 1, name: "Vampire"]
      [Category.create id: 2, name: "Werewolf"]
      [Category.create id: 3, name: "Zombie"]
      [Category.create id: 4, name: "Ghost"]
      [Category.create id: 5, name: "Other"]
    ]
  end

  def items
    [
      [Item.create id: 1, title: "Eat Cheese & Die - Grilled Cheese", description: "The ooziest grilled cheese", price: 50.00]
      [Item.create id: 2, title: "Welcome to Dead House", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 3, title: "Monster Blood", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 4, title: "Let's Get Invisible", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 5, title: "The Ghost Next Door", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 6, title: "The Haunted Mask", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 7, title: "Deep Trouble", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 8, title: "Go Eat Worms", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 9, title: "Ghost Beach", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 10, title: "Attack of the Mutant", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 11, title: "The Barking Ghost", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 12, title: "Tick Tock You're Dead", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 13, title: "Bad Hare Day", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 14, title: "The Coo Coo Cloock of Doom", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 15, title: "My Hairiest Adventure", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 16, title: "The Return of the Mummy", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 17, title: "Why I am Afraid of Bees", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 18, title: "You Can't Scare Me", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 19, title: "The Girl Who Cried Monster", description: "Spooky Spooky Spooky", price: 50.00]
      [Item.create id: 20, title: "Stay Out Of the Basement", description: "Spooky Spooky Spooky", price: 50.00]
    ]
  end
end
