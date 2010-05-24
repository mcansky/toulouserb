class User < ActiveRecord::Base
  # needed by authlogic
  acts_as_authentic

  def is_admin?
    return true
  end
  def self.find_by_login_or_email(login)
    find_by_login(login) || find_by_email(login)
  end
end