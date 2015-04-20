class Emergency < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :fire_severity, :police_severity, :medical_severity, presence: true
  validates_numericality_of :fire_severity, :police_severity, :medical_severity, greater_than_or_equal_to: 0
  
  after_create :dispatch_all_responders
  after_update :resolve?, if: Proc.new{resolved_at_changed?}
  
  has_many :responders
  
  def dispatched_capacity(type)
    Responder.where(emergency: self, type: type, on_duty: true).sum('capacity')
  end
  
  def resolve?
    responders.each { |responder| responder.update_attribute(:emergency, nil) }
  end
  
  private
  
  def dispatch_all_responders
    ['Fire', 'Police', 'Medical'].each do |type|
      dispatch_responder_type(type)
    end
  end
  
  def dispatch_responder_type(type)
    while Responder.responders_capacity(type)[3] != 0 && dispatched_capacity(type) < send(type_to_severity_symbol(type))
      possible_responders = Responder.where(type: type, emergency: nil, on_duty: true).where("capacity <= ?", send(type_to_severity_symbol(type)) - dispatched_capacity(type))
      responder = possible_responders.first
      responder = possible_responders.order(capacity: :desc).first unless possible_responders.empty?

      if responder.nil?
        responder =  Responder.where(type: type, emergency: nil, on_duty:true).order(capacity: :desc).first
      end 
      responder.update_attribute(:emergency, self)    
    end
    
    if dispatched_capacity(type) < send(type_to_severity_symbol(type))
      update_attribute(:full_response, false)
    end
  end
  
  def total_responders_by_type(type)
    Responder.where(type: type)
  end
  
  def type_to_severity_symbol(type)
    (type + "_severity").parameterize.underscore.to_sym
  end
end