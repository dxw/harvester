class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def self.takable_resource name
    @@resource_name = name
    @@resource_class = name.to_s.classify.constantize

    def update
      @resource = @@resource_class.find(params[:id])

      unless current_user.send("can_edit_#{@@resource_name}?", @resource)
        redirect_to send("#{@@resource_name}s_path")
      end

      if params[:commit] == 'Edit'
        @resource.take! current_user
      elsif ((params[:commit] == 'Save') || (params[:commit].start_with?('Next'))) && @resource.taken_by?(current_user)
        @resource.taken_by = nil

        update_resource

        @resource.save!
      end

      if params[:commit].start_with?('Next')
        next_resource!
      end

      if @resource.nil?
        redirect_to send("#{@@resource_name}s_path")
      else
        redirect_to send("edit_#{@@resource_name}_path", @resource.id)
      end
    end

    def get_next
      next_resource!

      if @resource.nil?
        redirect_to send("#{@@resource_name}s_path")
      else
        redirect_to send("edit_#{@@resource_name}_path", @resource.id)
      end
    end

    def next_resource!
      @resource = current_user.send("next_#{@@resource_name}")
      @resource.take! current_user if @resource
    end

    def next_resource
      raise NotImplementedError
    end

    def update_resource
      raise NotImplementedError
    end
  end
end
