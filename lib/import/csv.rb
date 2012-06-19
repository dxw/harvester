require 'csv'
require 'progressbar'

class ImportCSV
  def self.go file, department
    i = self.new file, department
    i.import
  end

  def initialize file, department
    @file = file
    @department = Department.find(department)
    @size = File.read(@file).split("\n").length
  end

  def import
    n = -1
    group_name = nil
    progress_bar = ProgressBar.new('Importing', @size)

    CSV.foreach(@file) do |row|
      n += 1
      progress_bar.set(n)
      # Header
      next if n.zero?

      # Groups
      if row[1].nil?
        group_name = nil
      end
      unless row[0].nil?
        group_name = row[0]
      end

      # Adding pages
      unless row[1].nil?
        group = Group.find_or_create_by_name(group_name) #TODO: use ! variant of this command when we upgrade from 3.2.2
        group.department = @department
        if group.name.nil?
          group.name = "Group #{group.id}"
          group_name = group.name
        end
        group.save!

        page = Page.create!(uri: row[1], name: row[2])
        if page.name.nil?
          page.name = page.uri.split('/')[-1]
        end
        page.group = group
        page.save!
      end
    end

    progress_bar.finish
  end
end
