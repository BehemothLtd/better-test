class ApplicationJob < ActiveJob::Base
  queue_as :low
end
