module CustomerCommands

  include HelperMethods  
  
    # set_customer_webviewer_access, webviewer should be 1 or 0, default is 1 = enabled
    def set_customer_webviewer_access(custid, webviewer = 1 , username, password)
    
      suburl = "&action=set_customer_webviewer_access" + "&" + 
        "custid="    + custid.to_s    + "&" + 
        "webviewer=" + webviewer.to_s + "&" +
        "username="  + CGI.escape(username)  + "&" +
        "password="  + CGI.escape(password)  + "&" +
        "noregemail=1" # noregemail means don't send the webviewer registration email
      
      call_target_url(suburl) #call private method

    end

    # add_customer, enable by default webviewer access and multi session logins and license number = 10
    def add_customer(name, email, webviewer = 1, webmslogins = 1, licenses = 10, company = 'MyCompany')
      
      suburl = "&action=add_customer" + "&" + 
        "name="  + CGI.escape(email)  + "&" + 
        "email=" + CGI.escape(email)  + "&" +
        "start_date=" + Time.now.utc.strftime("%m-%d-%Y") + "&" +
        "end_type=unlimited" + "&" +
        "noregemail=1"       + "&" +
        "licenses=#{licenses}" + "&" + 
        "webviewer=#{webviewer}" + "&" + 
	"webmslogins=#{webmslogins}" + '&' +
	"company=#{company}"

      call_target_url(suburl) #call private method

    end

    # list_customer customer id and email parameters
    def list_customer(custid = nil, email = nil)

      raise ArgumentError.new('Customer Id and email are nil.') if custid.nil? &&  email.nil?
      
      suburl = "&action=list_customer&nodocs=1" 
      
      if !custid.nil? && email.nil?
        suburl << "&custid=" + custid.to_s
      elsif custid.nil? && !email.nil? 
        suburl << "&email=" + CGI.escape(email)
      elsif !custid.nil? && !email.nil?
        suburl << "&custid=" + custid.to_s + "&email=" + CGI.escape(email)
      end
	  
      call_target_url(suburl) # call private method

    end #list_customer

    # list_customer customer id and email parameters with full docs
    def list_customer_full(custid = nil, email = nil)

      raise ArgumentError.new('Customer Id and email are nil.') if custid.nil? &&  email.nil?
      
      suburl = "&action=list_customer" 
      
      if !custid.nil? && email.nil?
        suburl << "&custid=" + custid.to_s
      elsif custid.nil? && !email.nil? 
        suburl << "&email=" + CGI.escape(email)
      elsif !custid.nil? && !email.nil?
        suburl << "&custid=" + custid.to_s + "&email=" + CGI.escape(email)
      end
	  
      call_target_url(suburl) # call private method

    end #list_customer_full

    # resend_customer_web_viewer_login
    def resend_customer_web_viewer_login(custid = nil, webonly = 1)

      raise ArgumentError.new('Customer Id and email are nil.') if custid.nil?

      suburl = "&action=resend_license"  
      suburl << "&custid=" + custid.to_s + "&webonly=" + webonly.to_s 
      
      call_target_url(suburl) # call private method

    end #resend_customer_web_viewer_login


    # set_customer_license_count
    def set_customer_license_count(custid = nil, licenses = nil)

      raise ArgumentError.new('Parameters are nil. Aborting...') if custid.nil? && licenses.nil?

      suburl = "&action=set_customer_license_count"
  
      if !custid.nil? && !licenses.nil?
        suburl << "&custid="  + custid.to_s + "&" + "licenses=" + licenses.to_s
      elsif licenses.nil?
        raise ArgumentError.new("licenses should not be nil/blank")
      elsif custid.nil?
        raise ArgumentError.new("custid should not be nil/blank")
      end

      call_target_url(suburl) # call private method

    end

  
    # fix this!!!!
    def update_customer_license_count(custid = nil, licenses = nil)
      
      raise ArgumentError.new("Customer id should be nil/blank") if custid.nil? || licenses.nil?

      suburl = "&action=update_customer_license_count"
      
      if custid.nil? && licenses.nil?
        raise ArgumentError.new('Parameters are nil. Aborting...')
      elsif !custid.nil? && !licenses.nil?
        suburl << "&custid=" + custid.to_s + "&" + "licenses=" + licenses.to_s
      end
      
      call_target_url(admin_url + suburl) # call private method

    end

    # Returns the file license as a data stream.
    def get_customer_license(custid = nil)

      raise ArgumentError.new("Customer id should not be nil/blank") if custid.nil?

      suburl = "&action=get_customer_license"
      suburl << "&custid=" + custid.to_s

      call_target_url(suburl) # call private method

    end

    def get_customer_webviewer_ssourl(custid = nil)

      raise ArgumentError.new("Customer id should not be nil/blank") if custid.nil?
      
      #call reset twice to reset ssourl for safe reasons
      suburl_reset = "&action=get_customer_webviewer_ssourl&custid=" + custid.to_s + "&reset=1"

      call_target_url(admin_url + suburl_reset)# call private method
      
      ## add here checks for return values / future work

      suburl = "&action=get_customer_webviewer_ssourl"
      suburl << "&custid=" + custid.to_s

      call_target_url(suburl)# call private method
      
    end

    # Sets customer Web Viewer multiple logins - This command is used to 
    # enable or disable multiple simultaneous logins for a customer's Web Viewer account.
    # webmslimit enter a value to specify the number of simultaneous logins (concurrent sessions) allowed.  
    # Enter 0 for unlimited (this is the default if webmslimit is not specified) or a specific number
    def set_customer_webviewer_ssourl(custid = nil, wewebmslimit = 0)

      raise ArgumentError.new("Customer id should not be nil/blank") if custid.nil?

      suburl = "&action=set_customer_multsim_logins"
      suburl << "&custid=" + custid.to_s + "&webmslogins=#{wewebmslimit}"

      call_target_url(suburl)# call private method
    
	end	

	# Accepts a response object and returns an array of customer's locklizard ids
    def list_customer_publications(custid = nil, email = nil)
	
      raise ArgumentError.new('Customer Id and email are nil.') if custid.nil? && email.nil?
      
      suburl = "&action=list_customer" 
      
      if !custid.nil? && email.nil?
        suburl << "&custid=" + custid.to_s
      elsif custid.nil? && !email.nil? 
        suburl << "&email=" + CGI.escape(email)
      elsif !custid.nil? && !email.nil?
        suburl << "&custid=" + custid.to_s + "&email=" + CGI.escape(email)
      end
	  
      http_result = call_target_url(suburl) # call private method
	  
      if success?(http_result)
        publications = http_result.to_s.split("\n")[1].split(" ")[-2].gsub('"', '').split(",") # return an array
      else
       raise ArgumentError.new('Parsing Error in list_customer_publications') 
      end
	  
      return publications.uniq if publications.is_a? Array
	  
    end #list_customer_publications


end
