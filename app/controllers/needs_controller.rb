class NeedsController < ApplicationController
  def edit
    @need = Need.all.first
  end
end
