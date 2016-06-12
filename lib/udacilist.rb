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

    class_name = get_classname_from_item_type(type)

    filtered_items=[]
    @items.each do |item|
      if item.instance_of?(Object.const_get(class_name))
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

    raise Errors::IndexExceedsListSize, "Index Exceeds List Size" if index>@items.length

    @items.delete_at(index - 1)
  end

  def delete_multiple_items(*indices)

    indices.each do |index|
      @items.delete_at(index) if is_index_valid?(index)
    end

  end


  def is_index_valid?(index)
    index>-1 and index<@items.length
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
      type=get_type_from_item(item)
      puts "#{position + 1})".colorize(:light_blue)+" #{item.details}"+ "type: #{type}"

    end
  end

  def get_classname_from_item_type(type)
    class_name = "TodoItem" if type == "todo"
    class_name = "EventItem" if type == "event"
    class_name = "LinkItem" if type == "link"

    if class_name.nil?
      raise Errors::InvalidItemType, "Invalid Item Type"
      return
    end

    return class_name


  end

  def get_type_from_item(item)
    type = "todo" if item.instance_of?(TodoItem)
    type = "event" if item.instance_of?(EventItem)
    type = "link" if item.instance_of?(LinkItem)

    return type

  end
end
