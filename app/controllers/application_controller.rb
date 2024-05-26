class ApplicationController < ActionController::Base
    include ActionController::Cookies
    rescue_from StandardError, with: :standard_error

    helper_method :user_signed_in?
    before_action :authenticate_user

    def app_response(message: 'success', status: 200, data: nil)
        render json: {
        message: message,
        data: data
        }, status: status
    end

    def user_signed_in?
        !CheckCurrentUserJob.perform_now(session[:user_id]).nil?
    end

    def authenticate_user
        redirect_to new_user_path, flash: {danger: 'You must be signed in'} if CheckCurrentUserJob.perform_now(session[:user_id]).nil?
    end

    def redirect_if_authenticated
        redirect_to root_path, flash: { info: 'You are already logged in.'} if user_signed_in?
    end

    private
    # rescue all common errors
    def standard_error(exception)
        app_response(message: 'failed', data: { info: exception.message }, status: :unprocessable_entity)
    end
end
