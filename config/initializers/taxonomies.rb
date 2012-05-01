HarvesterNg::Application.config.taxonomies = {
  attrs: {
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
