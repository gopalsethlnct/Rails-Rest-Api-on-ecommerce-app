class Order < ApplicationRecord
  belongs_to :user
  belongs_to :bill
end
