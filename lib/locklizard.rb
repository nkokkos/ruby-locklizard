require 'http'
require 'time'

require 'locklizard/endpoints'
require 'locklizard/helper_methods'
require 'locklizard/customer_commands'
require 'locklizard/publication_commands'
require 'locklizard/version'

class Api

  include HelperMethods
  include CustomerCommands
  include PublicationCommands

  def initialize(key = nil, locklizard_base_url = nil, locklizard_webviewer_url = nil) 
    @access_key = key || ENV['LOCKLIZARD_ACCESS_KEY']
    @locklizard_base_url = locklizard_base_url || ENV['LOCKLIZARD_BASE_URL']
    @locklizard_webviewer_url = locklizard_webviewer_url || ENV['LOCKLIZARD_VIEWER']
  end

end

# module LockLizard
# Define a class method "Api" within LockLizard module. 
# Using this approach, you can create an instance class like this:
# connection = LockLizard.Api("your access key")
module LockLizard

  def self.Api(key = nil, base_url = nil)
    return Api.new(key, base_url)
  end

  # https://stackoverflow.com/questions/16420236/why-are-constants-from-extended-module-not-available-in-class-methods-declared-w# 
end
