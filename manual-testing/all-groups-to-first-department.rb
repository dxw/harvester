Group.all.select{|g|g.department.nil?}.each{|g|g.department = Department.first; g.save!}
