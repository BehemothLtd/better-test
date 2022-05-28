class TestSession < ApplicationRecord
  has_many :run_histories

  enum status: {
    pending: 0,
    running: 1,
    finished: 2
  }
end
