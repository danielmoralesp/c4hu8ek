class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
    user = User.find_by(email: request.headers['HTTP_X_USER_EMAIL'])
    acces = user ? request.headers['X-API-TOKEN'] == user.api_token : false

    unless acces
      render json: { errors: "Acceso denegado" }, status: 401
    end
  end
end
