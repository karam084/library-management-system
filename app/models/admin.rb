class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
validates :name, presence: true
validates_uniqueness_of :email, confirmation: { case_sensitive: false }
validates_format_of :email, uniqueness: true, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
validates :password, presence: true, confirmation: true, length: { minimum: 8 }
end
