class Import
  def self.go uri
    i = self.new uri
    i.import
  end

  def initialize uri
    @db = CouchRest.database(uri)
  end

  def import
    @pager = CouchRest::Pager.new(@db)
    @pager.all_docs do |a|
      a.each do |row|
        doc = @db.get(row['id'])
        if doc['error']
          p "#{row['id']} SKIP"
          next
        end
        p "#{row['id']} DO"

        ###

        uri = doc['url']
        name = doc['title']
        if doc['crumbs']
          group_name = doc['crumbs'].select{|b|b['text']}.map{|b|b['text'].strip}.select{|b|b!=''}.join(' > ')
        else
          group_name = ''
        end

        group = Group.find_or_create_by_name!(group_name)
        page = Page.create!(uri: uri, name: name)
        page.group = group
        page.save!
      end
    end
  end
end
