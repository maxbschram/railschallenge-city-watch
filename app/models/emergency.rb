class Emergency < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :fire_severity, :police_severity, :medical_severity, presence: true
  validates_numericality_of :fire_severity, :police_severity, :medical_severity, greater_than_or_equal_to: 0
  
  has_many :responders
end