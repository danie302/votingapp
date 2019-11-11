class PoliticParty < ApplicationRecord
    validates :name, presence: true
    has_many :candidates
end
