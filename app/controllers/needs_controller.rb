class NeedsController < ApplicationController
  autocomplete :audience, :name, full: true
  autocomplete :need, :name, full: true
  autocomplete :new_page, :uri, full: true

  takable_resource :need

  def update_page page, formdata
    page.needs << @resource

    formdata[:new_pages].split(',').map{|s|s.strip}.each do |new_page|
      np = NewPage.find_by_uri(new_page)
      if np
        page.new_pages << np
      else
        page.new_pages.create!(uri: new_page)
      end
    end
  end

  def department_and_need_match
    unless @need.pages.map{|p|p.group}.map{|g|g.departments.map{|d|d.id}}.flatten.include? params[:department_id].to_i
      redirect_to department_needs_path
    end
  end

  ###

  def edit
    @need = Need.find(params[:id])
    department_and_need_match

    unless current_user.can_edit_need? @need
      redirect_to department_needs_path
    end
  end
end
