module GroupsHelper
  def taxonomy_tag tax
    taxonomies[tax]
  end

  def taxonomies
    HarvesterNg::Application.config.taxonomies
  end

  def taxonomies_a
    taxonomies.keys
  end
end
