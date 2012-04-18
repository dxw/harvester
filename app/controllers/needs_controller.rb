class NeedsController < ApplicationController
  autocomplete :audience, :name, full: true
  autocomplete :need, :name, full: true
  autocomplete :new_page, :uri, full: true

  takable_resource :need

  ###

  def edit
    @need = Need.find(params[:id])
  end
end
