class Book < ApplicationRecord
    belongs_to :library
  validates :isbn, presence: true
  validates :title, presence: true
  validates :authors, presence: true
  validates :published, presence: true
  validates :edition, presence: true
  validates :language, presence: true
  validates :count, presence: true
  validates_uniqueness_of :isbn, confirmation: { case_sensitive: false }
  
  mount_uploader :cover, CoverUploader

end
