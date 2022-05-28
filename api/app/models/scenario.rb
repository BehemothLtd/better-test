class Scenario < ApplicationRecord
  belongs_to :project

  enum type: {
    normal: 0,
    auth: 1
  }
end
