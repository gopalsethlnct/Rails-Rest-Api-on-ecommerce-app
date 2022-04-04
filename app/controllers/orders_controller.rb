class OrdersController < ApplicationController
    before_action :authorize_request
    load_and_authorize_resource
  
    def index
        @order=Order.where(user_id: current_user.id).page(params[:page] || 1).limit(5)
        render json: {
        "metadata": 
        {
            "page": @order.current_page,
            "per_page": @order.limit_value,
            "page_count": @order.total_pages,
            "total_count": @order.count,
            "links": [
              {"self": "/orders?page=#{@order.current_page}"},
              {"first": "/orders"},
              {"previous": "/orders?page=#{@order.current_page-1}"},
              {"next": "/orders?page=#{@order.next_page}"},
            ]
        },
        "data": {
            orders: @order
        }
      } 
    end
    
    def show
        @order = Order.find(params[:id])
        render json: @order
    end

    def create
        @order = Order.new(order_params)
        @order.user_id=current_user.id;
        if @order.save
          render json: @order, status: :created
        else
          render json: { errors: @order.errors.full_messages },
                 status: :unprocessable_entity
        end
    end

    def order_params
        params.permit(
            :bill_id, :status
        )
    end
end
