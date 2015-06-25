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
    
    order = Order.find(2)
    order.status = "paid"
    order.save!
    order = Order.find(4)
    order.status = "paid"
    order.save!
    
    order = Order.find(6)
    order.status = "complete"
    order.save!
    order = Order.find(8)
    order.status = "complete"
    order.save!

    order = Order.find(10)
    order.status = "cancelled"
    order.save!
    order = Order.find(12)
    order.status = "cancelled"
    order.save!
    
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
      ["Eat Cheese & Die", "The ooziest grilled cheese", 51.99, [monster, other], "http://ak-hdl.buzzfed.com/static/enhanced/web03/2012/8/13/15/enhanced-buzz-24632-1344884422-14.jpg"],
      ["Welcome to Dead House",  "That ain't gingerbread.", 23.26, [ghost], "http://cache.boston.com/bonzai-fba/Original_Photo/2010/10/29/house2__1288371510_5663.jpg"],
      ["Monster Blood Martini", "A sticky treat", 28.84, [monster, vampire], "http://i.imgur.com/GOyRZxD.jpg"],
      ["Let's Get Invisible", "It has 0 calories.", 93.19, [ghost], "http://i.imgur.com/yHAHhLt.png"],
      ["The Ghost Next Door", "Like eating Patrick Swayze", 63.38, [ghost], "http://i.imgur.com/jSHOJVJ.jpg"],
      ["The Haunted Mask", "The food speaks for itself.", 10.76, [ghost, werewolf], "http://i.imgur.com/M11NNID.jpg"],
      ["Deep Trouble", "Deep fried", 63.94, [other], "http://i.imgur.com/0MgrOZC.jpg"],
      ["Go Eat Worms", "Creepy crawly cupcakes", 38.23, [werewolf, other], "http://i.imgur.com/wsWCWsh.jpg"],
      ["Ghost on the Beach", "It's better than you-know-what.", 14.91, [ghost], "http://i.imgur.com/5fHgoXX.jpg"],
      ["Attack of the Mutant", "Mutant goo corn", 43.67, [werewolf, monster], "http://i.imgur.com/r6968CH.jpg"],
      ["The Barking Ghost", "It's woof-tastic.", 87.24, [werewolf, ghost], "http://i.imgur.com/SWV1TXk.jpg"],
      ["Tick Tock You're Dead", "Finish it before your time runs out.", 44.11, [other], "http://i.imgur.com/RNSRutH.png"],
      ["Bad Hare Day", "Hare today, gone tomorrow...", 25.71, [werewolf], "http://i.imgur.com/2i6uSKB.jpg"],
      ["The Coo Coo Clock of Doom", "It's not even food, it's just doom.", 83.12, [vampire, other], "http://i.imgur.com/67u6PNA.png"],
      ["My Hairiest Adventure", "Like a fur coat for your mouth", 67.71, [werewolf], "http://s3-media4.fl.yelpcdn.com/bphoto/69wdlcHxiNwzYOOA9rN_vA/o.jpg"],
      ["The Return of the Mummy", "You'll be saying, 'ymmmummy'", 98.99, [other], "http://eatrightchicago.org/wp-content/uploads/2013/02/Donut-Burger-636.jpg"],
      ["Why I am Afraid of Bees", "Let's bee serious", 32.12, [other], "http://i.imgur.com/VVu0D9u.jpg"],
      ["You Can't Scare Me", "But it will give you hiccups", 83.87, [vampire, ghost], "http://cdn.thatsnerdalicious.com/wp-content/uploads/2010/12/meat-lovers-banana-split-9294-1291275521-28.jpg?a0509d"],
      ["The Girl Who Cried Monster", "It's wolf", 12.43, [monster], "http://www.greatist.com/sites/default/files/wp-content/uploads/2011/06/ice-cream-ramen-1.jpg"],
      ["Stay Out Of the Basement", "Sadly, we live in one", 60.76, [ghost], "http://blog.eat24hours.com/wp-content/uploads/2014/06/palak.jpg"],
      ["The Horror of Camp JellyJam", "Better than whore of jellyjam", 54.44, [ghost], "http://www.chowstatic.com/assets/recipe_photos/30283_hurricane_jelly_shot.jpg"],
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
