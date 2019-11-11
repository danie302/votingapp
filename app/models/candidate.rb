class Candidate < ApplicationRecord
  belongs_to :politic_party
  has_one_attached :picture
  has_one_attached :gov_plan
  validates :name, presence: true
  validates :last_name, presence: true
  validates :cc, presence: true
  validates :city, presence: true
  validates :department, presence: true
  validates :position, presence: true
end
