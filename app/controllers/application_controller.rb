class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def self.takable_resource name
    @@resource_name = name
    @@resource_class = name.to_s.classify.constantize

    def update
      @resource = @@resource_class.find(params[:id])

      unless current_user.can_edit? @resource
        redirect_to send("#{@@resource_name}s_path")
      end

      if params[:commit] == 'Edit'
        @resource.take! current_user
      elsif ((params[:commit] == 'Save') || (params[:commit].start_with?('Next'))) && @resource.taken_by?(current_user)
        @resource.taken_by = nil

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
  end
end
