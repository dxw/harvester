class HarvesterController < ApplicationController
  before_filter :authenticate_user!
  def index
    @body_class << 'harvester-main'
  end
end
