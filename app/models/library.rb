class Library < ApplicationRecord
  validates :name, presence: true
  validates :university, presence: true
  validates :location, presence: true
  validates :borrow_limit, presence: true
  validates_uniqueness_of :name,  confirmation: { case_sensitive: false }
end
