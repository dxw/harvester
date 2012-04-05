class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def update
    p 'help'
    p 'wtf is going on here'
    p 'x'
    p current_user
    Group.find(params[:id]).take! current_user
  end

  def edit
    @xyz = Group.find(params[:id])
  end
end
