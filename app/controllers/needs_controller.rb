class NeedsController < ApplicationController
  def edit
    @need = Need.find(params[:id])
  end
end
