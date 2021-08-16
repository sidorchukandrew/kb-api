class ApplicationController < ActionController::API
    before_action :authenticate_user, except: [:login, :check_credentials]

    def authenticate_user
        header = request.headers["Authorization"]
        if header
            credentials = header.split(":")
            @current_user = User.find_by(username: credentials[0].titlecase)

            if @current_user && @current_user.authenticate(credentials[1])
            else
                return render status: :unauthorized
            end
        else
             return render status: :unauthorized
        end
    end
end
