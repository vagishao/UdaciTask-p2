class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    set_priority(options[:priority])
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
        format_due_date(@due)+ format_priority(@priority)
  end
end

