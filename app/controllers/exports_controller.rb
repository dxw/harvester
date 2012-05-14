class ExportsController < ApplicationController
  def show
  end

  def to_gdocs
    session = GoogleDrive.login(HarvesterNg::Application::config.google_docs[:username], HarvesterNg::Application::config.google_docs[:password])
    datetime = Time.zone.now.strftime('%Y-%m-%d %H:%M %Z')


    file = session.upload_from_string(get_csv, "Harvester #{datetime}", content_type: 'text/csv')

    if HarvesterNg::Application::config.google_docs[:collection]
      collection = session.collection_by_url(HarvesterNg::Application::config.google_docs[:collection])
      collection.add(file)
    end

    redirect_to file.human_url
  end

  private

  def get_csv
    require 'csv'
    CSV.generate do |csv|
      get_table.each do |row|
        csv << row
      end
    end
  end

  def get_table
    table = []

    # Header

    header = []
    header << 'Group'
    header << 'Name'
    header << 'URL'

    each_tax do |tax,tag|
      case tag[:type]
      when :checkboxes
        tag[:cls].all.each do |val|
          header << val.name
        end
      when :text
        header << tag[:cls].name
      end
    end
    table << header

    # Body

    Page.all.each do |page|
      line = []
      line << page.group.name
      line << page.name
      line << page.uri

      each_tax do |tax,tag|
        case tag[:type]
        when :checkboxes
          tag[:cls].all.each do |val|
            # Why doesn't this work?
            # line << (page.send(tax).include?(val) ? 't' : 'nil')
            line << (page.send(tax).map{|t|t.id}.include?(val.id) ? 'x' : '')
          end
        when :text
          line << page.send(tax).map{|t|t.name}.join(', ')
        end
      end

      table << line
    end

    table
  end

  def each_tax
    HarvesterNg::Application.config.taxonomies.each_pair do |tax,tag|
      yield tax,tag
    end
  end
end
