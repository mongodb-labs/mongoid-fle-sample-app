# rubocop:todo all
Mongoid.configure do
  target_version = "9.0"

  # Load Mongoid behavior defaults. This automatically sets
  # features flags (refer to documentation)
  config.load_defaults target_version

  # It is recommended to use config/mongoid.yml for most Mongoid-related
  # configuration, whenever possible, but if you prefer, you can set
  # configuration values here, instead:
  #
  #   config.log_level = :debug
  #
  # Note that the settings in config/mongoid.yml always take precedence,
  # whatever else is set here.
end

# Enable Mongo driver query cache for Rack
# Rails.application.config.middleware.use(Mongo::QueryCache::Middleware)

# Enable Mongo driver query cache for ActiveJob
# ActiveSupport.on_load(:active_job) do
#   include Mongo::QueryCache::Middleware::ActiveJob
# end

# Identify the current environment based on the RUBY_PLATFORMS environment
# variable, and use this to autopopulate the path to the crypt_shared
# library at ./vendor/crypt_shared/mongo_crypt_v1.[dll|dynlib|so]
#
# If detection fails the default file extension will be Linux's .so
def mongocrypt_path_helper
  platform = RUBY_PLATFORM.downcase
  ext = if RUBY_PLATFORM =~ /mswin32/
    "dll"
  elsif RUBY_PLATFORM =~ /darwin/
    "dylib"
  else
    "so" # default to Linux
  end

  File.join(Rails.root, 'vendor', 'crypt_shared', "mongo_crypt_v1.#{ext}")
end