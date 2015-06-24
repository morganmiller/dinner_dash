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
      ["Eat Cheese & Die", "The ooziest grilled cheese", 50.00, [Category.find(1)], "http://ak-hdl.buzzfed.com/static/enhanced/web03/2012/8/13/15/enhanced-buzz-24632-1344884422-14.jpg"],
      ["Welcome to Dead House",  "That ain't gingerbread, it's Shaun White.", 50.00, [Category.find(1), Category.find(2)], "http://cache.boston.com/bonzai-fba/Original_Photo/2010/10/29/house2__1288371510_5663.jpg"],
      ["Monster Blood Martini", "A sticky treat", 50.00, [Category.find(1)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["Let's Get Invisible", "It has 0 calories.", 50.00, [Category.find(4)], "http://i.imgur.com/yHAHhLt.png"],
      ["The Ghost Next Door", "Like eating Patrick Swayze", 50.00, [Category.find(4)], "http://i.imgur.com/jSHOJVJ.jpg"],
      ["The Haunted Mask", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://static.comicvine.com/uploads/original/11123/111233238/4580520-3376618-6086040402-fhd99.jpg"],
      ["Deep Trouble", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.dailymail.co.uk/i/pix/2013/11/15/article-2507879-196DFD9E00000578-543_634x638.jpg"],
      ["Go Eat Worms", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["Ghost Beach", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["Attack of the Mutant", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["The Barking Ghost", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["Tick Tock You're Dead", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["Bad Hare Day", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["The Coo Coo Cloock of Doom", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["My Hairiest Adventure", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["The Return of the Mummy", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["Why I am Afraid of Bees", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["You Can't Scare Me", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["The Girl Who Cried Monster", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
      ["Stay Out Of the Basement", "Spooky Spooky Spooky", 50.00, [Category.find(4)], "http://i.imgur.com/GOyRZxD.jpg"],
    ]
  end
end

Seed.start
