class Bill < ApplicationRecord
  has_many :product
  belongs_to :user
  has_one :order
end
