class EquipmentPolicy < ApplicationPolicy
  def show?
    # should return true or false depending on if the user can perform this action for this equipment
    return true
  end

  def create?
    return true
  end

  def update?
    return user_is_owner_or_admin?
  end
  
  def destroy?
    return user_is_owner_or_admin?
  end
  
  class Scope < Scope
    def resolve
      # `scope` == Equipment class itself
      # Should return an array of all equipments you're authorized to see
      scope.all
    end
  end

  private
  
  def user_is_owner_or_admin?
    # `record` == the equipment we passed in (usually @equipment)
    # `user` == current_user

    return record.user_id == user.id || user.admin == true
  end
end
