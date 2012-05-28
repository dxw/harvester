class DepartmentsController < ApplicationController
  def show
    redirect_to department_groups_path(params[:department])
  end

  def index
    @departments = Department.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
end
