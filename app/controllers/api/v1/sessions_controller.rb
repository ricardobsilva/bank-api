class Api::V1::SessionsController < DeviseTokenAuth::SessionsController
  skip_before_action :authenticate_api_v1_user!

  def render_create_success
    render json: @resource
  end
end
