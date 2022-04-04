class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login
  # before_action :authenticate_user!


  # POST /auth/login
  def login
      user = User.find_for_database_authentication(email: params[:email])
  # @user=current_user

    if user.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
