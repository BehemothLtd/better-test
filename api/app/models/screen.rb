class Screen < ApplicationRecord
  has_many :elements
  has_many :test_cases
  belongs_to :project
end
