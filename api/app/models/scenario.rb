class Scenario < ApplicationRecord
  belongs_to :project

  enum scenario_type: {
    normal: 0,
    auth: 1
  }
end
