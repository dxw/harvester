module GroupsHelper
  def taxonomy_tag tax
    taxonomies = {
      attributes: {cls: ::Attribute, type: :checkboxes},
      audiences: {cls: ::Audience, type: :text},
      needs: {cls: ::Need, type: :text}
    }

    taxonomies[tax]
  end
end
