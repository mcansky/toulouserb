class UserSession < Authlogic::Session::Base
  # use custome find by login method to allow both
  # login and email to be used for auth
  find_by_login_method :find_by_login_or_email
  # custome login fail message
  generalize_credentials_error_messages "Login failed."
end