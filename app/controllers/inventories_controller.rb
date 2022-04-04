class InventoriesController < ApplicationController
    before_action :authorize_request
    load_and_authorize_resource

    def index
        @stock=Inventory.all().page(params[:page] || 1).limit(10)
        render json: {
        "metadata": 
        {
            "page": @stock.current_page,
            "per_page": @stock.limit_value,
            "page_count": @stock.total_pages,
            "total_count": @stock.count,
            "links": [
              {"self": "/stocks?page=#{@stock.current_page}"},
              {"first": "/stocks"},
              {"previous": "/stocks?page=#{@stock.current_page-1}"},
              {"next": "/stocks?page=#{@stock.next_page}"},
            ]
        },
        "data": {
            stocks: @stock
        }
      } 
    end

    def show
        @stock = Inventory.where(product_id: params[:product_id], seller_id: params[:seller_id] )
        render json: @stock

    end

    def create
        @stock = Inventory.new(inventory_params)

        if @stock.save
          render json: @stock, status: :created
        else
          render json: { errors: @stock.errors.full_messages },
                 status: :unprocessable_entity
        end
    end

      # PATCH/PUT /inventory/1 or /inventory/1.json
    def update
        @inventory = Inventory.find(params[:id])
        @inventory.update(quantity: params[:inventory][:quantity])
        redirect_to article_path(@inventory)
    end
    def inventory_params
        params.permit(
            :product_id, :quantity, :seller_id
        )
    end    
end
