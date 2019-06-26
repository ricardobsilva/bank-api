class Api::V1::RegistrationsController < DeviseTokenAuth::RegistrationsController
  skip_before_action :authenticate_api_v1_user!
  
  def render_create_success
    render json: @resource,
           serializer: Api::V1::Registrations::UserSerializer,
           status: :created
  end

  def render_create_error
    render json: { errors: @resource.errors }, status: :unprocessable_entity
  end

  protected

  def sign_up_params
    params.require(:user).permit(:name, :cpf, :email, :password,
                                 :password_confirmation)
  end
end
