class RunHistorySerializer < ActiveModel::Serializer
  attributes :result, :test_case, :test_case_name
  belongs_to :test_case, serializer: ::TestCaseSerializer

  def test_case_name
    object.test_case.name
  end
end
