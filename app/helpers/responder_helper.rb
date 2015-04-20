module ResponderHelper
  def responders_capacity(type)
    a = []
    a << ResponderQuery.new.total(type: type)
    a << ResponderQuery.new.available(type: type)
    a << ResponderQuery.new.on_duty(type: type)
    a << ResponderQuery.new.available_and_on_duty(type: type)
    a.map(&:capacity)
  end
end
