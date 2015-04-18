class Responder < ActiveRecord::Base
  # Disable STI to allow use of 'type' column
  self.inheritance_column = nil
  
  validates :capacity, presence: true, inclusion: 1..5
  validates :name, presence: true, uniqueness: true
  validates :type, presence: true
  
  def as_json
    super(only: [:emergency_code, :type, :name, :capacity, :on_duty])
  end
  
end
