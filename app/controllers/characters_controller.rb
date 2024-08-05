class CharactersController < ApplicationController
  include BuildSelectableProject

  def index
    @selectable_projects = build_selectable_project
    @characters =
      Character
        .where(user: current_user)
        .filter_by_project_id(params[:project_id])
        .order(:display_order)
        .preload(:projects)
  end

  def show
    @character = Character.where(user: current_user).find(params[:id])
  end

  def new
    max_order = Character.where(user: current_user).maximum(:display_order)
    @character = Character.new(display_order: max_order + 1)
    @selectable_projects = build_selectable_project
  end

  def edit
    @character = Character.where(user: current_user).find(params[:id])
    @selected_project_ids = @character.projects.ids
    @selectable_projects = build_selectable_project
  end

  def create
    @character = Character.new(user: current_user)
    @character.update!(character_params)
    redirect_to(characters_path)
  end

  def update
    @character = Character.where(user: current_user).find(params[:id])
    @character.update!(character_params)
    redirect_to(characters_path)
  end

  def destroy
    @character = Character.where(user: current_user).find(params[:id])
    @character.destroy!
    redirect_to(characters_path)
  end

  private

  def character_params
    params
      .require(:character)
      .permit(:name, :gender, :job, :age, :interests, :display_order, project_ids: [])
  end
end
