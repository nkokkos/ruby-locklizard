module PublicationCommands
  
  # Include constants from LockLizardEndPoints module. They will be available to all the 
  # methods below:
  include LockLizardEndPoints
    
  ########### PUBLICATIONS #########################################
  # action=grant_publication_access
  # custid - id(s) of the customer to which the access is granted. The parameter can be included multiple times when you want to grant more than one customer access.
  # publication - id(s) of the publication to grant access to. The parameter can be included multiple times when you want to grant access to more than one publication
  # start_date – the date from which you want to grant access to the publication (optional)
  # end_date – the date from which you want to stop access to the publication (optional)

   # grant_publication_access for api/client/connect
   def grant_publication_access(custid = nil, publication = nil)
  
    suburl = "&action=grant_publication_access"
     
    if custid.nil? && publication.nil?
      raise ArgumentError.new('Parameters are nil. Aborting...')
    elsif !custid.nil? && !publication.nil?
      suburl << "&custid=" + custid.to_s + "&" + "publication=" + publication.to_s
    end
  
    call_target_url(suburl)
  
   end
  
  # Expects a customer locklicard id and an array of ids. Array can have 1 member too.
  def revoke_publication_access(custid = nil)
    raise ArgumentError.new('Custid Parameter is nil. Aborting...') if custid.nil?
	# raise ArgumentError.new('Publication parameter is not an Array. Aborting') if !publication.is_a? Array
  
    # first revoke access to all the publication the user has:
	publication_ids = list_customer_publications(custid).join(",") # this returns a comma separated string
   	
	unless publication_ids.empty? # if publication_ids string "is not" empty 
      suburl = "&action=revoke_publication_access"
	  suburl << "&custid=" + custid.to_s + "&" + "publication=" + publication_ids
	  call_target_url(suburl)
    else # if publication string is empty
	  return "publication_ids_null".freeze
	end
	
  end
  
  # Revoke all access to the publications, then apply again publications from publications array
  # Bug? For some reason, publication ids are returned twice the same. Perhaps need to replace array returned with uniq?
  def grant_publication_access_for_controller(custid = nil, publications_array = nil)

    raise ArgumentError.new('Custid Parameter is nil. Aborting...') if custid.nil?
	# raise ArgumentError.new('Publication parameter is not an Array. Aborting') if !publications_array.is_a? Array
    
	http_result = revoke_publication_access(custid)
	
	if (http_result.is_a? HTTP::Response)
	  if success?(http_result.to_s)
	    unless publications_array.empty? # if publications_array is not empty, grant publication access
          suburl = "&action=grant_publication_access"
	      suburl << "&custid=" + custid.to_s + "&" + "publication=" + publications_array.join(',')
	      call_target_url(suburl)
        end
	  else 
	    http_result.to_s #just return the http result
	  end
	elsif http_result == "publication_ids_null"
	  if !publications_array.empty? # if publications_array is not empty, grant publication access
        suburl = "&action=grant_publication_access"
	    suburl << "&custid=" + custid.to_s + "&" + "publication=" + publications_array.join(',')
	    call_target_url(suburl)
      end
	else
	  raise ArgumentError.new("ArgumentError in grant_publication_access")
	  #return "HTTP Result:#{http_result.to_s}"
	end
	
  end
  
  # list_publications
  def list_publications

    suburl = "&action=list_publications" 
  
    call_target_url(suburl) 
  
  end#list_publications
  
  # add_publication
  def add_publication(name, description)

    suburl = "&action=add_publication" 
      
    if name.nil? && description.nil?
      raise ArgumentError.new('Parameters are nil. Aborting...')
    elsif !name.nil? && description.nil?
      suburl << "&name=" + name
    elsif name.nil? && !description.nil? 
      raise ArgumentError.new('Name is nil. Aborting...')
    elsif !name.nil? && !description.nil?
      suburl << "&name=" + name  + "&description=" + description
    end

    call_target_url(suburl)
   
  end

  def list_publication_documents(pub_id)
    if pub_id.nil? then
      raise ArgumentError.new('Parameters are nil. Aborting...')
    end
    suburl = "&action=list_publication_documents"
    suburl << "&pubid=" + pub_id

    call_target_url(suburl)  
  end

end 
