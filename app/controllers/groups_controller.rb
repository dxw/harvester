class GroupsController < ApplicationController
  autocomplete :audience, :name, full: true
  autocomplete :need, :name, full: true

  takable_resource :group
  def resource_name
    :group
  end

  ###

  def index
    @groups = @department.groups
  end

  def edit
    @group = Group.find(params[:id])

    unless current_user.can_edit_department? @department
      redirect_to department_groups_path
    end
  end
end
