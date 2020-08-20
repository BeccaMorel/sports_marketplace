class BookingPolicy < ApplicationPolicy
  
  def create?
    return true
  end
  
  def update?
    return true
  end

  def destroy?
    return true
  end

  private

   def user_is_owner_or_admin?
    # `record` == the equipment we passed in (usually @booking)
    # `user` == current_user

    return record.user_id == user.id || user.admin == true
  end
end
