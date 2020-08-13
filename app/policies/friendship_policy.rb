class FriendshipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def update?
    record.receiver == user
  end

  def destroy?
    record.asker == user || record.receiver == user
  end
end
