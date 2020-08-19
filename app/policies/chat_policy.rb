class ChatPolicy < ApplicationPolicy
  attr_accessor :error_message

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    if !record.users.include?(user)
      @error_message = "You're not allowed to see this chat"
      false
    else
      true
    end
  end

  def create?
    true
  end

end
