module  LockLizardMethods
  include LockLizard     
  #helper methods:
    def success?(resp)
      resp.to_str.split("\n").first.gsub("\n",'') == SUCCESS
    end

    def failed?(resp)
      resp.to_str.split("\n").first.gsub("\n",'') == FAILED
    end

    def admin_url
      "?un=" +  URI.escape(@admin) + "&pw=" +  URI.escape(@password)
    end

    def clean_response(resp)
      if success?(resp)
        line_string = StringIO.new 
        line_string << resp.to_str.split
        line_string
      end
    end

  #webviewer should be 1 or 0
  def set_customer_webviewer_access(custid, webviewer, username, password)

    suburl = "&action=set_customer_webviewer_access" + "&" + 
            "custid="    + custid.to_s    + "&" + 
            "webviewer=" + webviewer.to_s + "&" +
            "username="  + URI.escape(username).to_s  + "&" +
            "password="  + URI.escape(password).to_s  + "&" +
            "noregemail=1"

    target_url = LockLizard::BASE_URL + LockLizard::admin_url + suburl 
 
   begin
     RestClient.get(target_url)
   rescue RestClient::ExceptionWithResponse => err
     err.response
   end

  end#set_customer_webviewer_access

def add_customer(name, email)
 suburl = "&action=add_customer" + "&" + 
            "name="  + URI.escape(email) + "&" + 
            "email=" + URI.escape(email) + "&" +
            "start_date="        + Time.now.utc.strftime("%m-%d-%Y") + "&" +
            "end_type=unlimited" + "&" +
            "noregemail=1"       + "&" +
            "licenses=10"        + "&" + 
            "webviewer=1"
 
    target_url = LockLizard::BASE_URL + LockLizard::admin_url + suburl 
 begin
   RestClient.get(target_url)
 rescue RestClient::ExceptionWithResponse => err
   err.response
 end

end#add_customer

def list_customer(custid=nil, email=nil)
 suburl = "&action=list_customer&nodocs=1" 
   if custid.nil? && email.nil?
     raise ArgumentError.new('Parameters are nil. Aborting...')
 elsif !custid.nil? && email.nil?
     suburl << "&custid=" + custid.to_s
 elsif custid.nil? && !email.nil? 
     suburl << "&email=" + URI.escape(email)
 elsif !custid.nil? && !email.nil?
     suburl << "&custid=" + custid.to_s
 end

 target_url = LockLizard::BASE_URL + LockLizard::admin_url + suburl
 
 begin
   RestClient.get(target_url)
 rescue RestClient::ExceptionWithResponse => err
   err.response
 end

end#list_customers

########### PUBLICATIONS #########################################
#action=grant_publication_access
#custid - id(s) of the customer to which the access is granted. The parameter can be included multiple times when you want to grant more than one customer access.
#publication - id(s) of the publication to grant access to. The parameter can be included multiple times when you want to grant access to more than one publication
#start_date – the date from which you want to grant access to the publication (optional)
#end_date – the date from which you want to stop access to the publication (optional)
def grant_publication_access(custid, publication)

suburl = "&action=grant_publication_access" 
 if custid.nil? && publication.nil?
   raise ArgumentError.new('Parameters are nil. Aborting...')
 elsif !custid.nil? && !publication.nil?
   suburl << "&custid="     + custid.to_s + "&" + "publication=" + publication.to_s
 end

 target_url = LockLizard::BASE_URL + LockLizard::admin_url + suburl
 
 begin
    RestClient.get(target_url)
  rescue RestClient::ExceptionWithResponse => err
    err.response
  end
end

def set_customer_license_count(custid, licenses)
   suburl = "&action=set_customer_license_count"
   if custid.nil? && licenses.nil?
     raise ArgumentError.new('Parameters are nil. Aborting...')
   elsif !custid.nil? && !licenses.nil?
     suburl << "&custid="  + custid.to_s + "&" +
               "licenses=" + licenses.to_s
    end
    target_url = LockLizard::BASE_URL + LockLizard::admin_url + suburl
  begin
    RestClient.get(target_url)
  rescue RestClient::ExceptionWithResponse => err
    err.response
  end
end

def update_customer_license_count(custid, licenses)
   suburl = "&action=update_customer_license_count"
   if custid.nil? && publication.nil?
         raise ArgumentError.new('Parameters are nil. Aborting...')
       elsif !custid.nil? && !licenses.nil?
         suburl << "&custid="     + custid.to_s + "&" +
                   "licenses="    + licenses.to_s

    end
    target_url = LockLizard::BASE_URL + LockLizard::admin_url + suburl
  begin
    RestClient.get(target_url)
  rescue RestClient::ExceptionWithResponse => err
    err.response
  end
end


def add_publication(name, description)
 suburl = "&action=add_publication" 
   if name.nil? && description.nil?
   raise ArgumentError.new('Parameters are nil. Aborting...')
 elsif !name.nil? && description.nil?
   suburl << "&name=" + URI.escape(name).to_s
 elsif name.nil? && !description.nil? 
   raise ArgumentError.new('Name is nil. Aborting...')
 elsif !name.nil? && !description.nil?
   suburl << "&name=" + URI.escape(name).to_s + "&description=" + URI.escape(description).to_s
 end
 target_url = LockLizard::BASE_URL + LockLizard::admin_url + suburl
  begin
    RestClient.get(target_url)
  rescue RestClient::ExceptionWithResponse => err
    err.response
  end

end#add_publication

def list_publications
  suburl = "&action=list_publications" 
  target_url = LockLizard::BASE_URL + LockLizard::admin_url + suburl
 
 begin
   RestClient.get(target_url)
 rescue RestClient::ExceptionWithResponse => err
   err.response
 end
end#list_publications
  
  def get_customer_license(custid=nil)
    suburl = "&action=get_customer_license"
    suburl << "&custid=" + custid.to_s 
    target_url = LockLizard::BASE_URL + LockLizard::admin_url + suburl
    begin
      RestClient.get(target_url)
    rescue RestClient::ExceptionWithResponse => err
      err.response
    end
  end

  def get_customer_webviewer_ssourl(custid=nil)
   suburl = "&action=get_customer_webviewer_ssourl"
   suburl << "&custid=" + custid.to_s
   target_url = LockLizard::BASE_URL + LockLizard::admin_url + suburl
   begin
     RestClient.get(target_url)
   rescue RestClient::ExceptionWithResponse => err
     err.response
   end
 end 


end
