class TreesController < ApplicationController
  def show
    @projects = Project.order(:display_order).where(user: current_user)
  end
end
