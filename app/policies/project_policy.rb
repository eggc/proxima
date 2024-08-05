class ProjectPolicy < ApplicationPolicy
  def index?
    record.visibility_public? || record.user_id == user.id
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
      scope.public_or_owned_by(user)
    end
  end
end
