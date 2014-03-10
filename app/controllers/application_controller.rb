class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json
  before_action :allow_cors
  before_action :authenticate!

  private

  def allow_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'

    head(:ok) if request.request_method == "OPTIONS"
  end

  def authenticate!
    unless request.env['HTTP_X_QUIZZARD_TOKEN']
      render json: { 'error' => 'Authentication error. Please identify yourself' }, status: 401
      return
    end

    @user = User.find_by_access_token(request.env['HTTP_X_QUIZZARD_TOKEN'].to_s)

    if @user.nil?
      render json: { 'error' => 'Authentication error. Please identify yourself' }, status: 401
      return
    end
  end

  def current_user
    @user
  end

  def required_present?(params = params, required_params = required_params)
    !required_params.any? { |p| p.is_a?(Hash) ? !required_present?(params, p.keys) : params[p].blank? }
  end
end
