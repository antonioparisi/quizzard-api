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
      render :json => { :error => 'Email already taken' }, :status => 412
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
        :picture => 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-frc3/t1/c0.0.320.320/p320x320/1509014_10202525550607447_385778307_n.jpg',
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
