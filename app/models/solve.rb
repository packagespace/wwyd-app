class Solve < ApplicationRecord
  belongs_to :problem
  belongs_to :user, optional: true
end
