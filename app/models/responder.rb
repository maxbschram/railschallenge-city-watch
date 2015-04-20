class Responder < ActiveRecord::Base
  # Disable STI to allow use of 'type' column
  self.inheritance_column = nil
  
  validates :capacity, presence: true, inclusion: 1..5
  validates :name, presence: true, uniqueness: true
  validates :type, presence: true
  
  belongs_to :emergency
  
  def as_json
    super(only: [:emergency_code, :type, :name, :capacity, :on_duty])
  end
  
  def self.responders_capacity(type)
    [Responder.where(type: type).sum('capacity'),
      Responder.where(type: type, emergency: nil).sum('capacity'),
      Responder.where(type: type, on_duty: true).sum('capacity'),
      Responder.where(type: type, emergency: nil, on_duty: true).sum('capacity')]
  end
  
end
