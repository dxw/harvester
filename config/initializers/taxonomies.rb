HarvesterNg::Application.config.taxonomies = {
  attrs: {
    cls: ::Attr,
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
