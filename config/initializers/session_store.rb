# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pjs-test-suite_session',
  :secret      => 'a82bbbf9f3950cac0004f3da001437c59a355a022997a886faa94eb9ca0f1633b6f0d9e08eda42687e42cc3ca384e9bdcb1296b92acdf8e2c0fbe41ff9e20ecf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
