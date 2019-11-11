class VotingPoint < ApplicationRecord
    validates :name, presence: true
    validates :address, presence: true
    validates :city, presence: true
    validates :department, presence: true
end
