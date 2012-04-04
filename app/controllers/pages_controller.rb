class PagesController < ApplicationController
  def update_multiple
    params[:pages].each do |k,v|

      page = Page.find(k)

      [:attributes, :audiences, :needs].each do |tax|
        if v[tax]
          page.set_tags(tax, v[tax])
        end
      end

    end

    redirect_to :harvester_index
  end
end
