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

  ###

  def edit
    @need = Need.find(params[:id])

    unless current_user.can_edit_need? @need
      redirect_to send("department_needs_path")
    end
  end
end
