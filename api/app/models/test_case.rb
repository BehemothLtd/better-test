class TestCase < ApplicationRecord
  belongs_to :screen

  serialize :steps, JSON
end
