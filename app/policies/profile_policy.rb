class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def index?
      true
    end

    def show?
      record.user == user
    end

    def new?
      record.user == user
    end
  end
end
