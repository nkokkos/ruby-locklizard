require 'rest_client'
require 'http'
require 'time'

require 'locklizard/endpoints'
require 'locklizard/methods'
require 'locklizard/version'

module  LockLizard

  #https://stackoverflow.com/questions/16420236/why-are-constants-from-extended-module-not-available-in-class-methods-declared-w#
  def self.Api(key=nil,secret=nil)
    return Api.new(key,secret)
  end

end
  
class Api
  #include methods from 'LockLizardMethods' module as instance methods
  
  include LockLizardMethods

  def initialize(accesskey=nil, secretkey=nil)
    @admin    = accesskey || ENV['LOCKLIZARD_ADMIN']
    @password = secretkey || ENV['LOCKLIZARD_PASSWORD']
  end
    
end#class Api
  

