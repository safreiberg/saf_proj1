# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
SafProj1::Application.initialize!

# Create a logger
Rails.logger = Logger.new(STDOUT)
