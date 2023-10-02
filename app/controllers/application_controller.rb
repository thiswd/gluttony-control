class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authenticate

  private

    def record_not_found
      render json: { error: "Record not found" }, status: :not_found
    end

    def authenticate
      api_key = request.headers['X-API-KEY']

      unless ApiKey.exists?(access_token: api_key)
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
end
