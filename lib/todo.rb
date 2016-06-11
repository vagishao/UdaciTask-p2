class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    # @due = options[:due] ? Date.parse(options[:due]) : options[:due]
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    # @priority = options[:priority]
    set_priority(options[:priority])
  end
  # def format_description
  #   "#{@description}".ljust(25)
  # end
  def format_date
    @due ? @due.strftime("%D") : "No due date"
  end
  def format_priority

    value = " ⇧" if @priority == "high"
    value = " ⇨" if @priority == "medium"
    value = " ⇩" if @priority == "low"
    value = "" if !@priority
    return value.colorize(:red)

  end

  def is_valid_priority?(new_priority)
    if new_priority !=nil and new_priority!="high" and new_priority!="medium" and new_priority!="low"
      return false
    else
      return true
    end
  end


  def set_priority(priority)

    raise Errors::InvalidPriorityValue, "Invalid Priority Value" if !is_valid_priority?(priority)
    @priority = priority


  end
  def details
    format_description(@description) + "due: " +
        format_date + format_priority
  end
end

