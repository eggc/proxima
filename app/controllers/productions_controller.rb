class ProductionsController < ApplicationController
  def index
    @productions = Production.all
  end

  def new
    @production = Production.new
  end

  def edit
    @production = Production.find(params[:id])
  end

  def create
    @production = Production.new(production_params)
    @production.save!
    redirect_to(productions_path)
  end

  def update
    @production = Production.find(params[:id])
    @production.update!(production_params)
    redirect_to(productions_path)
  end

  private

  def production_params
    params.require(:production).permit(:title, :media, :description)
  end
end
