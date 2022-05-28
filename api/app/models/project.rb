class Project < ApplicationRecord
  has_many :screens, dependent: :destroy
  has_many :scenarios, dependent: :destroy
end
