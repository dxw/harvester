class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def take
    p current_user
    Group.find(params[:id]).take! current_user
  end

  def edit
  end
end
