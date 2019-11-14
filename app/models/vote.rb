class Vote < ApplicationRecord
  belongs_to :voter
  belongs_to :voting_point
  validates :alcaldia, presence: true
  validates :gobernacion, presence: true
end
