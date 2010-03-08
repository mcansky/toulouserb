class User < ActiveRecord::Base
  # needed by authlogic
  acts_as_authentic

  # custom method to allow login or email login
  def self.find_by_login_or_email(login)
    find_by_login(login) || find_by_email(login)
  end

end