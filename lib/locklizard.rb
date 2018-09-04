require 'rest_client'
require 'time'
require "locklizard/version"
require "locklizard_methods"

  #constants for end point interface links
  BASE_URL = "https://drm.eap.gr/documents/Interop.php"
  WEBVIEWER_URL = "https://drm.eap.gr/webviewer "
  SUCCESS  = "OK"
  FAILED   = "Failed"
  
  class Api
    
    #include methods from module LockLizardMethods as instance methods
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