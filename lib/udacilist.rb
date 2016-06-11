class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    raise Errors::InvalidItemType, "Invalid Item Type" if type!="todo" and type!="event" and type!="link"

    type = type.downcase
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"

  end

  def filter(type)
    className = "TodoItem" if type == "todo"
    className = "EventItem" if type == "event"
    className = "LinkItem" if type == "link"

    if className.nil?
      puts "Wrong type: #{type}"
      return
    end


    filtered_items=[]
    @items.each do |item|
      if item.instance_of?(Object.const_get(className))
        filtered_items<<item
      end
    end

    if filtered_items.empty?
      puts "No items of type: #{type}"
    else
      print_array("Filtered by type: #{type}", filtered_items)
    end
    return filtered_items

  end

  def delete(index)

    raise Errors::IndexExceedsListSize, "Index Exceeds List Size" if index>=@items.length

    @items.delete_at(index - 1)
  end
  def all
    print_array(@title, @items)


  end


  def print_array(title, items)
    # code here
    puts "-" * title.length
    puts title
    puts "-" * @title.length
    items.each_with_index do |item, position|
      puts "#{position + 1})".colorize(:light_blue)+" #{item.details}"

    end
  end
end
