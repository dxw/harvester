module ApplicationHelper
  def buttons_for(resource)
    resource_name = resource.class.name.downcase
    render partial: 'application/buttons', locals: {resource: resource, resource_name: resource_name}
  end
end
