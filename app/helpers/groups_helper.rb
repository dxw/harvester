module GroupsHelper
  def taxonomy_tag tax
    taxonomies[tax]
  end

  def taxonomies
    {
      attributes: {
        cls: ::Attribute,
        type: :checkboxes
      },
      audiences: {
        cls: ::Audience,
        type: :text
      },
      needs: {
        cls: ::Need,
        type: :text
      }
    }
  end

  def taxonomies_a
    taxonomies.keys
  end
end
