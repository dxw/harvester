class Import
  def self.go uri
    i = self.new uri
    i.import
  end

  def initialize uri
    @db = CouchRest.database(uri)
  end

  def import
    p 'importing ... TODO'
  end
end
