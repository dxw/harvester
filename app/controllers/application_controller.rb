class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter do
    @body_class = []
  end

  attr :body_class
end
