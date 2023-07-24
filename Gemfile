source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Mongoid 9.0 that supports FLE is not yet released.
# Use the master branch of the Mongoid repository.
gem 'mongoid', github: 'mongodb/mongoid', branch: 'master'
# FFI is required for the libmongocrypt gem.
gem 'ffi'

# libmongocrypt is required for field level encryption.
# You can also download and install libmongocrypt manually
# following the instructions here:
# https://www.mongodb.com/docs/manual/core/csfle/reference/libmongocrypt/
gem 'libmongocrypt-helper'

# Devise is used to demonstrate how to use field level encryption
# in a multi-tenant application.
gem "devise", "~> 4.9"

# Standard Rails gems
gem "rails", "~> 7.0.6"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'byebug'
end
group :development do
  gem "web-console"
end
