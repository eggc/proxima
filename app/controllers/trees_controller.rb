class TreesController < ApplicationController
  def show
    @workspaces = policy_scope(Workspace).order(:display_order)
  end
end
