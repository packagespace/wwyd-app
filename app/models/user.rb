class User < ApplicationRecord
  # Provides methods to securely store and authenticate passwords
  has_secure_password

  # Associations
  has_many :sessions, dependent: :destroy
  has_many :solves, dependent: :nullify  # When user is deleted, keep solves but remove association

  # Validations
  validates :password, length: {minimum: 8}
  validates :email_address, presence: true, uniqueness: {case_sensitive: false}

  # Normalizations
  normalizes :email_address, with: ->(email) { email.strip.downcase }
end
