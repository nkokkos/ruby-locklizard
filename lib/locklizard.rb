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

  def initialize(key = nil)
    raise ArgumentError.new("Access key should not be nil/blank") if key.nil?  
    #863392e060aa7c6ef90a675e97062ee1599132ccd9300e0619fc19fdeb3a406f
    @access_key = key || ENV['LOCKLIZARD_ACCESS_KEY']
  end
    
end

# module LockLizard
# Define a class method "Api" within LockLizard module. 
# Using this approach, you can create an instance class like this:
# connection = LockLizard.Api("your access key")
module LockLizard

  def self.Api(key = nil)
    return Api.new(key)
  end

  # https://stackoverflow.com/questions/16420236/why-are-constants-from-extended-module-not-available-in-class-methods-declared-w# 
end