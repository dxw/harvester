class Page < ActiveRecord::Base
  attr_accessible :name, :uri
  belongs_to :group
  has_many :new_pages
  has_and_belongs_to_many :attrs, join_table: :pages_attributes
  has_and_belongs_to_many :audiences, join_table: :pages_audiences
  has_and_belongs_to_many :needs, join_table: :pages_needs

  def taxonomies
    {
      attrs:     [::Attr, :attrs, false],
      audiences: [::Audience, :audiences, true],
      needs:     [::Need, :needs, true],
    }
  end

  def set_tags(taxonomy, values)
    cls, mtd, create = taxonomies[taxonomy]

    values = values.uniq

    new_values = []
    values.each do |a|
      unless b = cls.find_by_name(a)
        b = cls.create!(name: a) if create
      end
      new_values << b unless b.nil?
    end

    self.send("#{mtd.to_s}=".to_sym, new_values)

  end

  def has_tag?(taxonomy, value)
    cls, mtd, create = taxonomies[taxonomy]

    self.send(mtd).any? do |t|
      t.name == value
    end
  end

  # Public: Fetch the terms which are set on this page in the given taxonomy
  #
  # taxonomy - One of :attrs (propositions), :audiences, or :needs
  #
  # Returns an array of the terms
  def tags(taxonomy)
    cls, mtd, create = taxonomies[taxonomy]

    self.send(mtd).map do |t|
      t.name
    end
  end


  # Public: Returns true if this page is done. A page is done when it has at 
  # least one proposition.
  def done?
    Page.attrs.empty?
  end
end
