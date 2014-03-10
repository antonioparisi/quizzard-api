class QuizesController < ApplicationController
  skip_before_action :authenticate!, :only => [:start]

  def start
    questions = ActiveModel::ArraySerializer.new(Question.all, :each_serializer => QuestionSerializer).to_json

    #Pusher['quiz'].trigger('start', {
      #message: {
        #questions: questions
      #}
    #})
  end

  def answer_correct
    
  end
end
