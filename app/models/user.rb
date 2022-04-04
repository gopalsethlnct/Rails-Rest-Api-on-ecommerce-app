class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :bills
  has_one :role
  has_many :orders
  def admin?
    role_id == Role.find_by(name: 'admin').id
  end

  def client?
    role_id == Role.find_by(name: 'client').id
  end 
  
  def seller?
    role_id == Role.find_by(name: 'seller').id
  end
end
