class Ability
  include CanCan::Ability
  def initialize(user)
    @user = user || User.new
    if @user.client?
      can :read, Product, user_id: @user.id
    elsif @user.admin?
      can :manage, :all
    elsif @user.seller?
      can :manage, Product
      can :manage, Inventory

    end
  end
end