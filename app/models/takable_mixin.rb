module TakableMixin
  def taken_by_user
    self.find(self.taken_by)
  end

  def taken?
    !self.taken_by.nil?
  end

  def take! user
    if can_be_taken_by? user
      self.taken_by = user.id
      save!
    else
      raise Exception
    end
  end

  def can_be_taken_by? user
    users_who_can_take_me.include? user
  end

  def users_who_can_take_me
    raise NotImplementedError
  end

  def taken_by? user
    taken_by == user.id
  end
end