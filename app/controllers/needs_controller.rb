class NeedsController < ApplicationController
  autocomplete :audience, :name, full: true
  autocomplete :need, :name, full: true
  autocomplete :new_page, :uri, full: true

  takable_resource :need

  def update_page page, formdata
    p page
    p formdata
  end

  ###

  def edit
    @need = Need.find(params[:id])
  end
end
