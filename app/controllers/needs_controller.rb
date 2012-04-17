class NeedsController < ApplicationController
  takable_resource :need

  ###

  def edit
    @need = Need.find(params[:id])
  end
end
