class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def update
    @group = Group.find(params[:id])

    if params[:commit] == 'Take'
      @group.taken_by = current_user
      @group.save!
    elsif params[:commit] == 'Save'
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

    redirect_to edit_group_path(@group.id)
  end

  def edit
    @group = Group.find(params[:id])
  end
end
