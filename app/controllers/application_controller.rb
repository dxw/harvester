module TakableResource
  def update
    @resource = resource_class.find(params[:id])

    unless current_user.send("can_edit_department?", @department)
      redirect_to send("department_#{resource_name}s_path")
      return
    end

    if params[:commit] == 'Edit'
      @resource.take! current_user
    elsif ((params[:commit] == 'Save') || (params[:commit].start_with?('Next'))) && @resource.taken_by?(current_user)
      @resource.taken_by = nil

      update_taxonomies

      @resource.save!
    end

    if params[:commit].start_with?('Next')
      next_resource!
    end

    redirect
  end

  def get_next
    next_resource!

    redirect
  end

  def redirect
    if @resource.nil?
      redirect_to send("department_#{resource_name}s_path", @department.id)
    else
      redirect_to send("edit_department_#{resource_name}_path", @department.id, @resource.id)
    end
    return
  end

  def next_resource!
    @resource = @department.send("next_#{resource_name}")
    @resource.take! current_user if @resource
  end

  def update_taxonomies
    Page.where('id in (?)', params[:pages].keys).find_each do |pp|
      page = params[:pages][pp.to_param]

      [:attrs, :audiences, :needs].each do |tax|
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

      update_page pp, page
    end

    @resource.save!
  end

  def update_page page, formdata
  end

  def resource_class
    resource_name.to_s.classify.constantize
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!


  around_filter :profile if Rails.env == 'development'

  def profile
    if params[:profile] && result = RubyProf.profile { yield }
      out = StringIO.new
      RubyProf::GraphHtmlPrinter.new(result).print out, :min_percent => 0
      self.response_body = out.string
    else
      yield
    end
  end

  def self.takable_resource name
    # @@resource_name = name
    # @@resource_class = name.to_s.classify.constantize

    before_filter do
    @department = Department.find(params[:department_id])
  end

  include TakableResource
  end
end
