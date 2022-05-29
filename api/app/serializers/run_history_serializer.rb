class RunHistorySerializer < ActiveModel::Serializer
  attributes :result, :test_case_id, :test_case_name, :created_at, :message, :project_id, :screen_id
  belongs_to :test_case, serializer: ::TestCaseSerializer

  def test_case_name
    object.test_case.name
  end

  def project_id
    object.test_case.screen.project_id
  end

  def screen_id
    object.test_case.screen_id
  end
end
