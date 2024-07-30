class ProductionsController < ApplicationController
  def index
    @productions = Production.where(user: current_user)
  end

  def new
    @production = Production.new
  end

  def edit
    @production = Production.where(user: current_user).find(params[:id])
  end

  def create
    @production = Production.new(user: current_user)
    @production.update!(production_params)
    redirect_to(productions_path)
  end

  def update
    @production = Production.where(user: current_user).find(params[:id])
    @production.update!(production_params)
    redirect_to(productions_path)
  end

  def destroy
    @production = Production.where(user: current_user).find(params[:id])
    @production.destroy!
    redirect_to(productions_path)
  end

  private

  def production_params
    params.require(:production).permit(:title, :media, :description)
  end
end
