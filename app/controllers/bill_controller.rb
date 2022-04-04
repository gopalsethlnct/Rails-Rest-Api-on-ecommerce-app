class BillController < ApplicationController
    before_action :authorize_request
    load_and_authorize_resource


    def index
        user_id=current_user.id
        @bills=Bill.where(user_id: user_id)
        render json: {product: @bills}, status: :ok 
    end

    def generate_bill
        total=0
        bills= params[:bill]
        # binding.pry
        quantity = Array.new(bills.size)
        price = Array.new(bills.size)
        product_id = Array.new(bills.size)
        i=0
        bills.each do |bill|
            product_id[i] = bill[:product_id]
            quantity[i]= bill[:quantity]
            price[i]= bill[:price]
            @stock =Inventory.find_by_product_id(product_id[i])
            Inventory.update(@stock.id,{ quantity: @stock.quantity-quantity[i]},)
            i=i+1
            total= total+(bill[:quantity]*bill[:price])
        end
       
        create(product_id,quantity,price,total)
        # render json: {
        #     "data": {
        #         product: product_id,
        #         quantity: quantity,
        #         price:  price,
        #         total: total
        #     }
        #   } 
    end

    def create(product_id,quantity,price,total)
        @bill = Bill.new(product_id: product_id,quantity: quantity,price: price,total: total,user_id: 1)
        @bill.user_id = current_user.id
        # binding.pry

        if @bill.save!
        #   Order.create(bill_id: @bill.id,status: "recieved")
          render json: @bill, status: :created
        else
          render json: { errors: @bill.errors.full_messages },
                 status: :unprocessable_entity
        end
    end

    def bill_params
        params.permit(
            :product_id, :quantity, :price, :total
        )
    end
end
