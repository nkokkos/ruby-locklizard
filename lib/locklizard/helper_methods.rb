module HelperMethods

  # include LockLizardEndPoints constants as constants to the following methods
  include LockLizardEndPoints

  #helper methods:

  def success?(response = nil)
    raise ArgumentError if response.nil?
    response.to_str.split("\n").first.gsub(/\n/,'') == SUCCESS
  end
  
  def failed?(response = nil)
    raise ArgumentError if response.nil?
    response.to_str.split("\n").first.gsub(/\n/,'') == FAILED
  end

  # clean respone
  def clean_response(response)
   raise "Not Implemented"
  end
  
  private

  def admin_url
    #"?un=" +  URI.escape(@admin) + "&pw=" +  CGI.escape(@password)
   "?key=#{@access_key}"
  end

  def base_url
    @locklizard_base_url
  end
  
  # Call final target url after having build the whole final url link.
  # This method raises an HTTP::Error exception, therefore 
  # we need to catch the exception at controller level:
  # In controller we need to do this:
  # def mycontroller
  #   begin  
  #     response = call_target_url(url)
  #   rescue HTTP::Error => e
  #     "Exception Occurred: #{e}. Message: #{e.message}. Backtrace:  \n #{e.backtrace.join("\n")}"
  #   end
  # end
  def call_target_url(target)
    final_target = "#{base_url}#{admin_url}#{target}"
    http = HTTP.timeout(connect: 5, read: 5)
    http.get(final_target)
  end

end
