class QuestionSerializer < ActiveModel::Serializer
  attributes :title, :correct_number

  has_many :answers, :serializer => AnswerSerializer
end
