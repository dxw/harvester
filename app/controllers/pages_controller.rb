class PagesController < ApplicationController
  def update_multiple
    params[:pages].each do |k,v|

      page = Page.find(k)

      [
        [Attribute, :attributes, false],
        [Audience, :audiences, true],
        [Need, :needs, true],
      ].each do |cls, mtd, create|
        page.send(mtd).clear
        v[mtd.to_s].each do |a|
          unless b = cls.find_by_name(a)
            b = cls.create!(name: a) if create
          end
          page.send(mtd) << b unless b.nil?
        end
      end

    end

    redirect_to :harvester_index
  end
end
