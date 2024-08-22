class PagePolicy < AbstractUserItemPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.joins(:notebook).merge(Notebook.where(user:))
    end
  end
end
