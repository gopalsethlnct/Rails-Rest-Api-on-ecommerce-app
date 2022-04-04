class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
 def deny
 end
    def authorize_request
      unless user_id_in_token?
        render json: { errors: ['Not Authenticated'] }, status: :unauthorized
        return
      end
      @current_user = User.find(auth_token[:user_id])
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  
    private
    def http_token
        @http_token ||= if request.headers['Authorization'].present?
          request.headers['Authorization'].split(' ').last
        end
    end
  
    def auth_token
      @auth_token ||= JsonWebToken.decode(http_token)
    end
  
    def user_id_in_token?
      http_token && auth_token && auth_token[:user_id].to_i
    end
end
