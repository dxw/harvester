class ExportsController < ApplicationController
  def show
  end

  def to_gdocs
    session = GoogleSpreadsheet.login(HarvesterNg::Application::config.google_docs[:username], HarvesterNg::Application::config.google_docs[:password])
    datetime = Time.zone.now.strftime('%Y-%m-%d %H:%M %Z')
    spreadsheet = session.create_spreadsheet("Harvester #{datetime}")

    ws = spreadsheet.worksheets.first

    get_table.each_with_index do |row,y|
      row.each_with_index do |cell,x|
        ws[y+1,x+1] = cell
      end
    end

    ws.save

    redirect_to spreadsheet.human_url
  end

  private

  def get_table
    table = []

    # Header

    header = []
    header << 'Group'

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
