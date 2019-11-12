class VotingPoint < ApplicationRecord
    has_many :voters
    validates :name, presence: true
    validates :address, presence: true
    validates :city, presence: true
    validates :department, presence: true
end
