# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_arbousier_session',
  :secret      => 'b4bba76090ae905d1753c6775485a2b8a8de656af8f26ce8a7fe557cfaa9067ed551f14c53ca37dc30e1bc72212860571a8d5ae627ef3dfca68b5bfe929fdeea'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
