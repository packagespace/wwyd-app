class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  #todo add min password length
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
