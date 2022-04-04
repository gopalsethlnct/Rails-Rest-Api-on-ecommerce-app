class SellersController < ApplicationController
    before_action :authorize_request
    load_and_authorize_resource


    def index
        @sellers=Seller.all()
        render json: {product: @sellers}, status: :ok 
    end

    def create
        @seller = Seller.new(task_params)

        if @seller.save
          render json: @seller, status: :created
        else
          render json: { errors: @seller.errors.full_messages },
                 status: :unprocessable_entity
        end
    end

    def task_params
        params.permit(
            :user_id, :name
        )
    end   
end
