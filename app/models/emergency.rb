class Emergency < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :fire_severity, :police_severity, :medical_severity, presence: true
  validates :fire_severity, :police_severity, :medical_severity, numericality: { greater_than_or_equal_to: 0 }

  after_create :dispatch_all_responders
  after_update :resolve, if: :resolved_at

  has_many :responders

  private

  def dispatched_capacity(type)
    ResponderQuery.new.on_duty(emergency: self, type: type).capacity
  end

  def resolve
    responders.each { |responder| responder.update_attribute(:emergency, nil) }
  end

  def dispatch_all_responders
    [:fire, :police, :medical].each do |type|
      dispatch_responder_type(type.to_s.capitalize)
    end
  end

  def dispatch_responder_type(type)
    while available_and_on_duty_responders?(type) && insufficient_dispathced_capacity?(type)
      possible_responders = ResponderQuery.new.available_and_on_duty(type: type).order(capacity: :desc)
      responder = possible_responders.find_by('capacity <= ?', severity(type) - dispatched_capacity(type))
      responder ||= possible_responders.first
      responder.update_attribute(:emergency, self)
    end
    update_attribute(:full_response, false) if insufficient_dispathced_capacity?(type)
  end

  def insufficient_dispathced_capacity?(type)
    dispatched_capacity(type) < severity(type)
  end

  def available_and_on_duty_responders?(type)
    ResponderQuery.new.available_and_on_duty(type: type).capacity != 0
  end

  def severity(type)
    send("#{type.downcase}_severity".to_sym)
  end
end
