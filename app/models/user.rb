class User < ApplicationRecord
  # Provides methods to securely store and authenticate passwords
  has_secure_password

  # Associations
  has_many :sessions, dependent: :destroy
  has_many :solves

  # Validations
  validates :password, length: {minimum: 8}

  # Normalizations
  normalizes :email_address, with: ->(email) { email.strip.downcase }
end
