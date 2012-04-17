class GroupsController < ApplicationController
  autocomplete :audience, :name, full: true
  autocomplete :need, :name, full: true

  takable_resource :group

  def update_resource
    params[:pages].each do |id,page|
      pp = Page.find(id)
      [:attributes, :audiences, :needs].each do |tax|
        if page[tax]
          if page[tax].is_a? String
            tags = page[tax].split(',').map{|s|s.strip}.select{|s|s.length > 0}
          elsif page[tax].is_a? Hash
            tags = page[tax].keys
          else
            raise NotImplementedError
          end

          pp.set_tags(tax, tags)
        else
          pp.set_tags(tax, [])
        end
      end
    end
  end

  ###

  def index
    @groups = current_user.groups
  end

  def edit
    @group = Group.find(params[:id])

    unless current_user.can_edit_group? @group
      redirect_to groups_path
    end
  end
end
