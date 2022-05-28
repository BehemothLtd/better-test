class Screen < ApplicationRecord
  has_many :elements, dependent: :destroy
  has_many :test_cases, dependent: :destroy
  belongs_to :project
end
