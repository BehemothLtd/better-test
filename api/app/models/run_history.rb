class RunHistory < ApplicationRecord
  belongs_to :test_case

  serialize :images, JSON

  enum result: {
    failed: 0,
    passed: 1,
    pending: 2,
    cancelled: 3
  }
end
