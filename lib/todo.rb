class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    # @due = options[:due] ? Date.parse(options[:due]) : options[:due]
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    format_priority
  end
  # def format_description
  #   "#{@description}".ljust(25)
  # end
  def format_date
    @due ? @due.strftime("%D") : "No due date"
  end
  def format_priority
    raise Errors::InvalidPriorityValue, "Invalid Priority Value" if @priority !=nil and @priority!="high" and @priority!="medium" and @priority!="low"

    value = " ⇧" if @priority == "high"
    value = " ⇨" if @priority == "medium"
    value = " ⇩" if @priority == "low"
    value = "" if !@priority
    return value.colorize(:red)


  end
  def details
    format_description(@description) + "due: " +
        format_date + format_priority
  end
end
