HarvesterNg::Application.config.taxonomies = {
  attributes: {
    cls: ::Attribute,
    type: :checkboxes
  },
  needs: {
    cls: ::Need,
    type: :text
  },
  audiences: {
    cls: ::Audience,
    type: :text
  }
}
