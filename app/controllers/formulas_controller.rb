class FormulasController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @formulas = if params[:keywords]
                 Formula.where('name ilike ?',"%#{params[:keywords]}%")
               else
                 []
               end
  end

  def show
    @formula = Formula.find(params[:id])
  end

  def create
    @formula = Formula.new(params.require(:formula).permit(:name,:instructions))
    @formula.save
    render 'show', status: 201
  end

  def update
    formula = Formula.find(params[:id])
    formula.update_attributes(params.require(:formula).permit(:name,:instructions))
    head :no_content
  end

  def destroy
    formula = Formula.find(params[:id])
    formula.destroy
    head :no_content
  end
end
