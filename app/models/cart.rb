class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_item(item_id)
    contents[item_id.to_s] ||= 0
    contents[item_id.to_s] += 1
  end
  
  def items
    contents.map { |id, quantity| [Item.find(id), quantity] }.to_h
  end
  
  
end
