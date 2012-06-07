module TakableMixin

  def self.included(base)
    base.scope(:not_done, base.where(:done => false))
    base.scope(:not_taken, base.where(:taken_by => nil))
  end

  def taken_by_user
    taken? ? User.find(self.taken_by) : nil
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

  def done?
    self.done
  end

  def _done?
    raise NotImplementedError
  end

  def available?
    !done? && !taken?
  end
end
