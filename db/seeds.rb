class Seed
  def self.start
    new.generate
  end

  def generate
    create_users
    create_categories
    create_items
    create_orders
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
    items.each do |title, description, price, categories, image|
      Item.create(title: title, description: description, price: price, categories: categories, image: image)
    end
    puts "Items: #{Item.all.map(&:title).join(", ")} created."
  end

  def create_orders
    carts.each do |session_cart|
      cart = Cart.new(session_cart)
      OrderCreator.execute_order(cart, random_user)
    end
    Order.find(2).status = "paid"
    Order.find(4).status = "paid"

    Order.find(6).status = "completed"
    Order.find(8).status = "completed"

    Order.find(10).status = "cancelled"
    Order.find(12).status = "cancelled"
    
    puts "Orders for the following users: #{Order.all.map(&:user_id).join(", ")} created."
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
  
  def random_user
    User.find([1,2,3,4].sample)
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
    [ "Vampire", "Werewolf", "Monster", "Ghost", "Other" ]
  end
  
  def vampire
    Category.find_by(name: "Vampire")
  end

  def werewolf
    Category.find_by(name: "Werewolf")
  end

  def monster
    Category.find_by(name: "Monster")
  end

  def ghost
    Category.find_by(name: "Ghost")
  end

  def other
    Category.find_by(name: "Other")
  end
  
  def items
    [
      ["Eat Cheese & Die", "The ooziest grilled cheese", 50.00, [monster, other], "http://ak-hdl.buzzfed.com/static/enhanced/web03/2012/8/13/15/enhanced-buzz-24632-1344884422-14.jpg"],
      ["Welcome to Dead House",  "That ain't gingerbread, it's Shaun White.", 50.00, [ghost], "http://cache.boston.com/bonzai-fba/Original_Photo/2010/10/29/house2__1288371510_5663.jpg"],
      ["Monster Blood Martini", "A sticky treat", 50.00, [monster, vampire], "http://i.imgur.com/GOyRZxD.jpg"],
      ["Let's Get Invisible", "It has 0 calories.", 50.00, [ghost], "http://i.imgur.com/yHAHhLt.png"],
      ["The Ghost Next Door", "Like eating Patrick Swayze", 50.00, [ghost], "http://i.imgur.com/jSHOJVJ.jpg"],
      ["The Haunted Mask", "The food speaks for itself.", 50.00, [ghost, werewolf], "http://i.imgur.com/M11NNID.jpg"],
      ["Deep Trouble", "Spooky Spooky Spooky", 50.00, [other], "http://i.imgur.com/0MgrOZC.jpg"],
      ["Go Eat Worms", "Creepy crawly cupcakes", 50.00, [werewolf, other], "http://i.imgur.com/wsWCWsh.jpg"],
      ["Ghost on the Beach", "It's better than you-know-what.", 50.00, [ghost], "http://i.imgur.com/5fHgoXX.jpg"],
      ["Attack of the Mutant", "Mutant goo corn", 50.00, [werewolf, monster], "http://i.imgur.com/r6968CH.jpg"],
      ["The Barking Ghost", "It's woof-tastic.", 50.00, [werewolf, ghost], "http://i.imgur.com/SWV1TXk.jpg"],
      ["Tick Tock You're Dead", "Finish it before your time runs out.", 50.00, [other], "http://i.imgur.com/RNSRutH.png"],
      ["Bad Hare Day", "Hare today, gone tomorrow...", 50.00, [werewolf], "http://i.imgur.com/2i6uSKB.jpg"],
      ["The Coo Coo Clock of Doom", "It's not even food, it's just doom.", 50.00, [vampire, other], "http://i.imgur.com/67u6PNA.png"],
      ["My Hairiest Adventure", "Spooky Spooky Spooky", 50.00, [werewolf], "http://i.imgur.com/GOyRZxD.jpg"],
      ["The Return of the Mummy", "Spooky Spooky Spooky", 50.00, [other], "http://i.imgur.com/GOyRZxD.jpg"],
      ["Why I am Afraid of Bees", "Spooky Spooky Spooky", 50.00, [other], "http://i.imgur.com/GOyRZxD.jpg"],
      ["You Can't Scare Me", "Spooky Spooky Spooky", 50.00, [vampire, ghost], "http://i.imgur.com/GOyRZxD.jpg"],
      ["The Girl Who Cried Monster", "Spooky Spooky Spooky", 50.00, [monster], "http://i.imgur.com/GOyRZxD.jpg"],
      ["Stay Out Of the Basement", "Spooky Spooky Spooky", 50.00, [ghost], "http://i.imgur.com/GOyRZxD.jpg"],
    ]
  end
  
  def carts
    [
      { "1" => 2, "3" => 1, "4" => 1 },
      { "2" => 2, "5" => 1 },
      { "8" => 1, "6" => 1, "9" => 3 },
      { "5" => 5 },
      { "5" => 1, "18" => 1 },
      { "10" => 1, "12" => 1, "13" => 2, "11" => 3 },
      { "1" => 4, "9" => 1},
      { "17" => 2, "2" => 1},
      { "3" => 1, "4" => 1, "5" => 1, "6" => 1},
      { "18" => 2},
      { "7" => 1, "14" => 1, "20" => 4},
      { "3" => 1 },
      { "5" => 1, "15" => 5 }
    ]
  end
end

Seed.start
