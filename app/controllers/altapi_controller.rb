class AltapiController < ApplicationController

    protect_from_forgery with: :null_session

    def login
        if params[:callsign].nil? || params[:callsign].empty? || params[:password].nil? || params[:password].empty?
            render json: {error: "emptyparams"}
        else
            @user = User.find_by_callsign(params[:callsign].upcase)
            if !@user.nil? && @user.valid_password?(params[:password])
                @token = AltapiToken.new
                @token.user = @user
                while !@token.valid?
                    @token.token = Forgery(:basic).text(exactly: 30)
                end
                if @token.save
                    render json: {token: @token.token}
                else
                    render json: {error: "token"}
                end
            else
                render json: {error: "unauthorized"}
            end
        end
    end

    def logout
        @token = AltapiToken.find_by_token(params[:token])
        unless @token.nil?
            if @token.destroy
                render json: {success: "success"}
            else
                render json: {error: "failure"}
            end
        else
            render json: {error: "unauthorized"}
        end
    end

    def user_data
        @token = AltapiToken.find_by_token(params[:token])
        unless @token.nil?
            @user = @token.user
            render json: @user
        else
            render json: {error: "unauthorized"}
        end
    end
end
