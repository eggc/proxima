class ProjectPolicy < AbstractUserItemPolicy
  def index?
    record.visibility_public? || record.user_id == user.id
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.public_or_owned_by(user)
    end
  end
end
