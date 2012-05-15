class ExportJob
  @queue = :export

  def self.perform(exported_data_id, type)
    exported_data = ExportedData.find(exported_data_id)

    self.__send__(type, exported_data)
  end

  def self.to_gdocs(exported_data)
    session = GoogleDrive.login(HarvesterNg::Application::config.google_docs[:username], HarvesterNg::Application::config.google_docs[:password])
    datetime = Time.zone.now.strftime('%Y-%m-%d %H:%M %Z')

    file = session.upload_from_string(self.get_csv, "Harvester #{datetime}", content_type: 'text/csv')

    if HarvesterNg::Application::config.google_docs[:collection]
      collection = session.collection_by_url(HarvesterNg::Application::config.google_docs[:collection])
      collection.add(file)
    end

    exported_data.uri = file.human_url
    exported_data.save!
  end

  def self.get_csv
    CSV.generate do |csv|
      self.get_rows do |row|
        csv << row
      end
    end
  end

  def self.get_rows
    # Header

    header = []
    header << 'Group'
    header << 'Name'
    header << 'URL'

    self.each_tax do |tax,tag|
      case tag[:type]
      when :checkboxes
        tag[:cls].all.each do |val|
          header << val.name
        end
      when :text
        header << tag[:cls].name
      end
    end
    yield header

    # Body

    Page.all.each do |page|
      line = []
      line << page.group.name
      line << page.name
      line << page.uri

      self.each_tax do |tax,tag|
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

      yield line
    end

    nil
  end

  def self.each_tax
    HarvesterNg::Application.config.taxonomies.each_pair do |tax,tag|
      yield tax,tag
    end
  end
end
