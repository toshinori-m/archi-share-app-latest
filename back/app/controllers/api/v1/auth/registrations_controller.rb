module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        private

        def sign_up_params
          params.permit(:name, :email, :password, :password_confirmation, :image)
        end

        def account_update_params
          params.permit(:name, :email, :introduction, :image)
        end
      end
    end
  end
end
