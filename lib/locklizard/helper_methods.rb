module HelperMethods

  #helper methods:

  def success?(resp)
    resp.to_str.split("\n").first.gsub("\n",'') == SUCCESS
  end
  
  def failed?(resp)
    resp.to_str.split("\n").first.gsub("\n",'') == FAILED
  end

  # clean respone
  def clean_response(resp)
    if success?(resp)
      line_string = StringIO.new 
      line_string << resp.to_str.split
      line_string
    end
  end
  
  private

  def admin_url
    #"?un=" +  URI.escape(@admin) + "&pw=" +  URI.escape(@password)
   "?key=" + URI.escape(@access_key)
  end
  
  # call final target url after having build the whole final url link from method:
  def call_target_url(target)
    begin
      #RestClient.get(target_url)
      HTTP.get(target)
    #rescue RestClient::ExceptionWithResponse => err
    rescue Exception => e 
      err.response
    end
  end
  

end