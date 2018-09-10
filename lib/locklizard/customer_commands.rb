module CustomerCommands
  
  include LockLizardEndPoints     
  
    # set_customer_webviewer_access, webviewer should be 1 or 0
    def set_customer_webviewer_access(custid, webviewer, username, password)
    
      suburl = "&action=set_customer_webviewer_access" + "&" + 
        "custid="    + custid.to_s    + "&" + 
        "webviewer=" + webviewer.to_s + "&" +
        "username="  + URI.escape(username).to_s  + "&" +
        "password="  + URI.escape(password).to_s  + "&" +
        "noregemail=1"
      
      call_target_url(BASE_URL + admin_url + suburl) #call private method

    end

    # add_customer
    def add_customer(name, email)
      
      suburl = "&action=add_customer" + "&" + 
        "name="  + URI.escape(email)  + "&" + 
        "email=" + URI.escape(email)  + "&" +
        "start_date=" + Time.now.utc.strftime("%m-%d-%Y") + "&" +
        "end_type=unlimited" + "&" +
        "noregemail=1"       + "&" +
        "licenses=10"        + "&" + 
        "webviewer=1"
 
      call_target_url(BASE_URL + admin_url + suburl) #call private method

    end

    # list_customer
    def list_customer(custid = nil, email = nil)
    
      suburl = "&action=list_customer&nodocs=1" 
      
      if custid.nil? && email.nil?
        raise ArgumentError.new('Customer Id and email are nil.')
      elsif !custid.nil? && email.nil?
        suburl << "&custid=" + custid.to_s
      elsif custid.nil? && !email.nil? 
        suburl << "&email=" + URI.escape(email)
      elsif !custid.nil? && !email.nil?
        suburl << "&custid=" + custid.to_s
      end

      #puts "#{BASE_URL}#{admin_url}#{suburl}"
      call_target_url(BASE_URL + admin_url + suburl) # call private method

    end #list_customer

    # set_customer_license_count
    def set_customer_license_count(custid, licenses)
    
      suburl = "&action=set_customer_license_count"
  
      if custid.nil? && licenses.nil?
        raise ArgumentError.new('Parameters are nil. Aborting...')
      elsif !custid.nil? && !licenses.nil?
        suburl << "&custid="  + custid.to_s + "&" + "licenses=" + licenses.to_s
      end

      call_target_url(BASE_URL + admin_url + suburl) # call private method

    end

    def update_customer_license_count(custid, licenses)
      
      raise ArgumentError.new("Customer id should be nil/blank") if custid.nil?

      suburl = "&action=update_customer_license_count"
      
      if custid.nil? && publication.nil?
        raise ArgumentError.new('Parameters are nil. Aborting...')
      elsif !custid.nil? && !licenses.nil?
        suburl << "&custid=" + custid.to_s + "&" + "licenses=" + licenses.to_s
      end

      call_target_url(BASE_URL + admin_url + suburl) # call private method

    end

    def get_customer_license(custid = nil)

      raise ArgumentError.new("Customer id should be nil/blank") if custid.nil?

      suburl = "&action=get_customer_license"
      suburl << "&custid=" + custid.to_s 
      
      call_target_url(BASE_URL + admin_url + suburl) # call private method
    
    end

    def get_customer_webviewer_ssourl(custid = nil)

      raise ArgumentError.new("Customer id should be nil/blank") if custid.nil?

      suburl = "&action=get_customer_webviewer_ssourl"
      suburl << "&custid=" + custid.to_s
    
      call_target_url(BASE_URL + admin_url + suburl)# call private method

    end
    
end
