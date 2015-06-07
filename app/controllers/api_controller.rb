class ApiController < ApplicationController
    before_filter :doorkeeper_authorize!

    def user_data
        render json: current_resource_owner
    end

    private

    def current_resource_owner
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end

    def doorkeeper_unauthorized_render_options
        {json: '{"status": "failure", "message":"401 Unauthorized"}'}
    end
end
