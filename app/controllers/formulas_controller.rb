class FormulasController < ApplicationController
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
end
