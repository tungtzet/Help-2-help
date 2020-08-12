class User::FriendshipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(asker: user).or(scope.where(receiver: user))
    end
  end

  def update?
    true
  end


  def index?
    true
  end

  def destroy?
    record.asker == user
  end
  
end