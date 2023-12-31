class HoldRequest < ApplicationRecord
    belongs_to :student
    belongs_to :book
end
