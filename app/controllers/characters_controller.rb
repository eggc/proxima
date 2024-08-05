class CharactersController < ApplicationController
  def index
    @characters =
      Character
        .order(:display_order)
        .where(user: current_user)
        .preload(:projects)
  end

  def new
    @character = Character.new
  end

  def edit
    @character = Character.where(user: current_user).find(params[:id])
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
    params.require(:character).permit(:name, :gender, :job, :age, :interests, :display_order)
  end
end
