class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def update
    @group = Group.find(params[:id])

    if params[:commit] == 'Take'
      @group.taken_by = current_user
      @group.save!
    elsif ((params[:commit] == 'Save') || (params[:commit] == 'Get a group')) && @group.taken_by?(current_user)
      @group.taken_by = nil

      params[:pages].each do |id,page|
        pp = Page.find(id)
        [:attributes, :audiences, :needs].each do |tax|
          if page[tax]
            if page[tax].is_a? String
              tags = page[tax].split(',').map{|s|s.strip}
            elsif page[tax].is_a? Hash
              tags = page[tax].keys
            else
              raise NotImplementedError
            end

            pp.set_tags(tax, tags)
          end
        end
      end
      @group.save!
    end

    if params[:commit] == 'Get a group'
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
    @group = Group.next
    @group.take! current_user
  end

  def edit
    @group = Group.find(params[:id])
  end
end
