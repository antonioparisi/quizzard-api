class QuestionsController < ApplicationController
  def index
    render :json => Question.all, :root => false, :status => 200
  end
end
