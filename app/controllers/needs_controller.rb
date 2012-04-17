class NeedsController < ApplicationController
  takable_resource :need

  def next_resource!
    @resource = current_user.next_group
    @resource.take! current_user if @resource
  end

  ###

  def edit
    @need = Need.find(params[:id])
  end
end
