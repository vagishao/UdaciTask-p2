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


  def delete(index)

    raise Errors::IndexExceedsListSize, "Index Exceeds List Size" if index>=@items.length

    @items.delete_at(index - 1)
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

end
