class CorsController < ApplicationController
  def options
    render :nothing => true, :status => 200
  end
end
