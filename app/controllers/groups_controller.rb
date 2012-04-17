class GroupsController < ApplicationController
  autocomplete :audience, :name, full: true
  autocomplete :need, :name, full: true

  takable_resource :group

  def next_resource!
    @resource = current_user.next_group
    @resource.take! current_user if @resource
  end

  ###

  def index
    @groups = current_user.groups
  end

  def edit
    @group = Group.find(params[:id])

    unless current_user.can_edit? @group
      redirect_to groups_path
    end
  end
end
