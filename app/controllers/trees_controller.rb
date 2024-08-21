class TreesController < ApplicationController
  def show
    @notebooks = policy_scope(Notebook).order(:display_order)
  end
end
