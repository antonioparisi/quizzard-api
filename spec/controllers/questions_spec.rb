require 'spec_helper'

describe QuestionsController do
  describe 'GET /index' do
    before do
      @user = create(:user)
      @question = create(:question)
      create(:answer, :question => @question)
    end

    it 'is ok' do
      request.env['HTTP_X_QUIZZARD_TOKEN'] = @user.access_token
      get :index

      response.status.should == 200

      body = JSON.load(response.body)
      body.should_not be_nil
      body.size.should == 1
    end

    it 'authenticate' do
      get :index

      response.status.should == 401

      body = JSON.load(response.body)
      body['error'].should == 'Authentication error. Please identify yourself'
    end
  end
end
