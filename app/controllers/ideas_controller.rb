class IdeasController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @ideas = policy_scope(Idea).order(:display_order)
  end

  def edit
    @idea = Idea.find(params[:id])
    authorize(@idea)
  end

  def create
    max_order = Idea.where(user: current_user).maximum(:display_order) || 0
    @idea = Idea.new(user: current_user, display_order: max_order + 1)
    authorize(@idea)
    @idea.save!
    redirect_to(ideas_path)
  end

  def update
    @idea = Idea.find(params[:id])
    authorize(@idea)
    @idea.update!(idea_params)
    redirect_to(ideas_path)
  end

  def destroy
    @idea = Idea.find(params[:id])
    authorize(@idea)
    @idea.destroy!
    redirect_to(ideas_path)
  end

  private

  def idea_params
    params.require(:idea).permit(:body, :emote, :display_order)
  end
end
