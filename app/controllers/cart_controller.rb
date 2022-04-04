class CartController < ApplicationController
    before_action :authorize_request
    load_and_authorize_resource


    def index
        user_id=current_user.id
        @cart=Cart.where(user_id: user_id)
        render json: {product: @cart}, status: :ok 
    end

 
    def create
        @cart = Cart.new(cart_params)
        if @cart.save
          render json: @cart, status: :created
        else
          render json: { errors: @cart.errors.full_messages },
                 status: :unprocessable_entity
        end
    end

    def cart_params
        params.permit(
            :quantity, :product_id, :user_id
        )
    end
end
