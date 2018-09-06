require 'rest_client'
require 'time'
require_relative 'locklizard/methods'
require_relative 'locklizard/version'
require_relative 'locklizard/endpoints'  
  
class Api
  #include methods from 'LockLizardMethods' module as instance methods
    include LockLizardMethods

    def initialize(accesskey=nil, secretkey=nil)
      @admin    = accesskey || ENV['LOCKLIZARD_ADMIN']
      @password = secretkey || ENV['LOCKLIZARD_PASSWORD']
    end
    
end#class Api
  
module  LockLizard
  def self.Api(key=nil,secret=nil)
    return Api.new(key,secret)
  end
end
