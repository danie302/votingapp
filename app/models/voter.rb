class Voter < ApplicationRecord
  belongs_to :voting_point
  validates :name, presence: true
  validates :last_name, presence: true
  validates :cc, presence: true
  validates :city, presence: true
  validates :department, presence: true
end
