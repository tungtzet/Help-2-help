class User::FriendshipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(asker: user).or(scope.where(receiver: user))
    end
  end

  def update?
    record.receiver == user
  end


  def index?
    true
  end

  def destroy?
    record.asker == user || record.receiver == user
  end
  
end