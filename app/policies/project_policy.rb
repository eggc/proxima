class ProjectPolicy < AbstractUserItemPolicy
  def index?
    record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user:)
    end
  end
end
