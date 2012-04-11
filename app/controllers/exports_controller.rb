class ExportsController < ApplicationController
  def show
  end

  def to_gdocs
    redirect_to 'https://docs.google.com/'
  end
end
