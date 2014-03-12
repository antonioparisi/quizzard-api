class QuizesController < ApplicationController
  skip_before_action :authenticate!, :only => [:start]

  def start
    REDIS.flushall

    questions = ActiveModel::ArraySerializer.new(Question.all, :each_serializer => QuestionSerializer).to_json

    Pusher['quiz'].trigger('start', {
      message: {
        questions: questions
  }
    })
  end

  def answer_correct
    Pusher['quiz'].trigger('correct_answer', {
      message: {
        user_id: current_user.id,
        score: REDIS.incr(current_user.id)
      }
    })
  end
end
