class ProductsController < ApplicationController
    before_action :authorize_request
    load_and_authorize_resource

    def index
        @product=Product.all().page(params[:page] || 1).limit(5)
        render json: {
        "metadata": 
        {
            "page": @product.current_page,
            "per_page": @product.limit_value,
            "page_count": @product.total_pages,
            "total_count": @product.count,
            "links": [
              {"self": "/products?page=#{@product.current_page}"},
              {"first": "/products"},
              {"previous": "/products?page=#{@product.current_page-1}"},
              {"next": "/products?page=#{@product.next_page}"},
            ]
        },
        "data": {
            product: @product
        }
      } 
    end
    def show
        @products = Product.find(params[:id])
        render json: @products

    end

    def create
        # binding.pry
        # authorize!
        @product = Product.new(product_params)

        if @product.save
          render json: @product, status: :created
        else
          render json: { errors: @product.errors.full_messages },
                 status: :unprocessable_entity
        end
    end

    def product_params
        params.permit(
            :name, :price, :size, :category
        )
    end
end
