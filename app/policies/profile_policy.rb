class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if @params.present?
        scope.global_search(@params)
      else
        scope.all
      end 
    end
  end

  def show?
    true
  end

  def edit?
    update?
  end

  def update?
    record.user == user
  end

  def destroy?
    update?
  end

  def create?
    true
  end
end

