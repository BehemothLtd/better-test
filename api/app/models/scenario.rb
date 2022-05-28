class Scenario < ApplicationRecord
  belongs_to :project

  serialize :steps, JSON
end
