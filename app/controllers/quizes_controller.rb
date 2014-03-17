class QuizesController < ApplicationController
  skip_before_action :authenticate!, :only => [:start, :next_question, :rank]

  def start
    # Reset scoreboard
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
        score: REDIS.zincrby('rank', 1, current_user.id)
      }
    })
  end

  def next_question
    Pusher['quiz'].trigger('next_question', {})
  end

  def rank
    users = []
    REDIS.zrangebyscore('rank', '-inf', '+inf').each { |u| users << User.find_by_id(u).fullname }

    Pusher['quiz'].trigger('rank', {
      message: {
        rank: users.first(3)
      }
    })
  end
end
