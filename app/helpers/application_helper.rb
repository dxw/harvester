module ApplicationHelper
  def buttons_for(resource)
    render partial: 'application/buttons', locals: {resource: resource}
  end
end
