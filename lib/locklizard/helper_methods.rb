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
    resp.to_str.split("\n").first.gsub(/\n/,'') == FAILED
  end

  # clean respone
  def clean_response(response)
   raise "Not Implemented"
  end
  
  private

  def admin_url
    #"?un=" +  URI.escape(@admin) + "&pw=" +  URI.escape(@password)
   "?key=" + URI.escape(@access_key)
  end

  def base_url
    URI.escape(@locklizard_base_url)
  end
  
  # call final target url after having build the whole final url link from method:
  def call_target_url(target)
  
    final_target = base_url + admin_url + target
    
	#puts "Calling call_target_url "
	#puts final_target
	#puts "------------------------"
	
    begin
      #RestClient.get(target_url)
      HTTP.get(final_target)
    #rescue RestClient::ExceptionWithResponse => err
    rescue Exception => e 
      e.message
    end
    
  end

end
