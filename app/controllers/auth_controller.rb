class AuthController < ApplicationController
    def login
        @current_user = User.find_by(username: params[:name])

        if @current_user && @current_user.authenticate(params[:password])

            @current_user.increment!(:number_of_logins)
            render json: @current_user, except: [:password_digest]
        
        else
            return render status: :unauthorized
        end
    end

    def check_credentials
        @current_user = User.find_by(username: params[:name])

        if @current_user && @current_user.authenticate(params[:password])
            render json: @current_user, except: [:password_digest]
        else
            return render status: :unauthorized
        end
    end

    def password
        @current_user.password = params[:password]
        @current_user.save

        render json: @current_user, except: [:password_digest]
    end
end
