class Screen < ApplicationRecord
  has_many :elements, dependent: :destroy
  has_many :test_cases, dependent: :destroy
  has_many :test_sessions, dependent: :destroy
  belongs_to :project
  belongs_to :pre_script, class_name: "Scenario", optional: true

  accepts_nested_attributes_for :elements
end
