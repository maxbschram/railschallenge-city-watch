class Emergency < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :fire_severity, :police_severity, :medical_severity, presence: true
  validates :fire_severity, :police_severity, :medical_severity, numericality: { greater_than_or_equal_to: 0 }

  after_create :dispatch
  after_update :resolve, if: :resolved_at

  has_many :responders

  def severity(type)
    send("#{type.downcase}_severity".to_sym)
  end

  def dispatched_capacity(type)
    ResponderQuery.new.on_duty(emergency: self, type: type).capacity
  end

  private

  def dispatch
    EmergencyDispatch.new(self).dispatch_all_responders
  end

  def resolve
    responders.each { |responder| responder.update_attribute(:emergency, nil) }
  end
end
