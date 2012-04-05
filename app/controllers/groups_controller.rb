class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def update
    @group = Group.find(params[:id])

    if params[:commit] == 'Take'
      @group.taken_by = current_user
      @group.save!
    end

    redirect_to edit_group_path(@group.id)
  end

  def edit
    @group = Group.find(params[:id])
  end
end
