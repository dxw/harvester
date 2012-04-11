HarvesterNg::Application.config.taxonomies = {
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
