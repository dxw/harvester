class Page < ActiveRecord::Base
  attr_accessible :name, :uri
  has_and_belongs_to_many :attributes, join_table: :pages_attributes
  has_and_belongs_to_many :audiences, join_table: :pages_audiences
  has_and_belongs_to_many :needs, join_table: :pages_needs

  def set_tags(taxonomy, values)
    taxonomies = {
      attributes: [::Attribute, :attributes, false],
      audiences:  [::Audience, :audiences, true],
      needs:      [::Need, :needs, true],
    }

    cls, mtd, create = taxonomies[taxonomy]

    self.send(mtd).clear
    values.each do |a|
      unless b = cls.find_by_name(a)
        b = cls.create!(name: a) if create
      end
      self.send(mtd) << b unless b.nil?
    end

  end

end
