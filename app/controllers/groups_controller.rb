class GroupsController < ApplicationController
  autocomplete :audience, :name, full: true
  autocomplete :need, :name, full: true

  def index
    @groups = current_user.groups
  end

  def update
    @group = Group.find(params[:id])

    unless current_user.can_edit? @group
      redirect_to groups_path
    end

    if params[:commit] == 'Edit'
      @group.take! current_user
    elsif ((params[:commit] == 'Save') || (params[:commit] == 'Next group')) && @group.taken_by?(current_user)
      @group.taken_by = nil

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
      @group.save!
    end

    if params[:commit] == 'Next group'
      next_group!
    end

    if @group.nil?
      redirect_to groups_path
    else
      redirect_to edit_group_path(@group.id)
    end
  end

  def get_a_group
    next_group!

    if @group.nil?
      redirect_to groups_path
    else
      redirect_to edit_group_path(@group.id)
    end
  end

  def next_group!
    @group = current_user.next_group
    @group.take! current_user if @group
  end

  def edit
    @group = Group.find(params[:id])

    unless current_user.can_edit? @group
      redirect_to groups_path
    end
  end
end
