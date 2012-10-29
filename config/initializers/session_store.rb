# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mail_session',
  :secret      => '80ff3a8f6be4ae9e83f226ee6d3b562c9282842f72c81f1c0c176106fcdeb585e5ee78ce0ac2f25d996f72375a89be9b0e786a2d722357b13eec76fa08d86edc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
