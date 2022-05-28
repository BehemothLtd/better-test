class Project < ApplicationRecord
  has_many :screens, dependent: :destroy
end
