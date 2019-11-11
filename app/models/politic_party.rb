class PoliticParty < ApplicationRecord
    validates :name, presence: true
end
