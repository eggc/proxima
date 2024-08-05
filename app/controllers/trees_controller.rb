class TreesController < ApplicationController
  def show
    @projects = policy_scope(Project).order(:visibility, :display_order)
  end
end
