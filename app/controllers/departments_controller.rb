class DepartmentsController < ApplicationController
  def show
    redirect_to department_groups_path(params[:department])
  end

  def index
    @departments = current_user.departments
  end
end
