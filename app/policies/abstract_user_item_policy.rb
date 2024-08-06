class AbstractUserItemPolicy < ApplicationPolicy
  def index?
    record.user_id == user.id
  end

  def create?
    record.user_id == user.id
  end

  def update?
    record.user_id == user.id
  end

  def destroy?
    record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user:)
    end
  end
end
