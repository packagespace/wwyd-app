class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :solves

  validates :password, length: { minimum: 8}
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
