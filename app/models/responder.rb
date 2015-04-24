class Responder < ActiveRecord::Base
  # Disable STI to allow use of 'type' column
  self.inheritance_column = nil
  validates :capacity, presence: true, inclusion: 1..5
  validates :name, presence: true, uniqueness: true
  validates :type, presence: true
  belongs_to :emergency
end
