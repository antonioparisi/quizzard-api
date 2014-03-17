class UsersController < ApplicationController
  skip_before_action :authenticate!, :only => [:create]

  def create
    if !required_present?
      render :json => { :error => "Please, provide #{required_params.join(', ')}" }, :status => 400
      return
    end

    begin
      User.create!(user_params)
    rescue ActiveRecord::RecordNotUnique => not_unique
      user = User.find_by_email(params[:email])
      user.update_attributes!(:access_token => params[:access_token])

      render :json => { :success => true }, :status => 200
      return
    rescue => error
      render :json => { :error => error.message }, :status => 412
      return
    end

    render :json => { :success => true }, :status => 201
  end

  def join
    Pusher['waitingRoom'].trigger('join', {
      message: {
        :id => current_user.id,
        :picture => current_user.picture,
        :fullname => current_user.fullname,
        :score => 0
      }
    })
  end

  private

  def required_params
    [:email, :name, :lastname, :access_token, :picture]
  end

  def user_params
    params.permit(required_params)
  end
end
