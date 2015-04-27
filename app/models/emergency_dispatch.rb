class EmergencyDispatch
  include ResponderHelper

  def initialize(emergency)
    @emergency = emergency
  end

  def dispatch_all_responders
    [:fire, :police, :medical].each do |type|
      dispatch_responder_type(type.to_s.capitalize)
    end
  end

  def dispatch_responder_type(type)
    while available_and_on_duty_responders?(type) && insufficient_dispatched_capacity?(type)
      possible_responders = ResponderQuery.new.available_and_on_duty(type: type).order(capacity: :desc)
      responder = possible_responders.find_by('capacity <= ?', remaining_severity(type))
      responder ||= possible_responders.first
      responder.update_attribute(:emergency, @emergency)
    end
    @emergency.update_attribute(:full_response, false) if insufficient_dispatched_capacity?(type)
  end

  def insufficient_dispatched_capacity?(type)
    remaining_severity(type) > 0
  end

  def remaining_severity(type)
    @emergency.severity(type) - @emergency.dispatched_capacity(type)
  end
end
