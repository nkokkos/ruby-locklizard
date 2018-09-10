module PublicationCommands
  
  #Include constants from LockLizardEndPoints module. They will be available to all the 
  #methods below:
  include LockLizardEndPoints
    
  ########### PUBLICATIONS #########################################
  # action=grant_publication_access
  # custid - id(s) of the customer to which the access is granted. The parameter can be included multiple times when you want to grant more than one customer access.
  # publication - id(s) of the publication to grant access to. The parameter can be included multiple times when you want to grant access to more than one publication
  # start_date – the date from which you want to grant access to the publication (optional)
  # end_date – the date from which you want to stop access to the publication (optional)

  # grant_publication_access
  def grant_publication_access(custid, publication)
  
    suburl = "&action=grant_publication_access"
     
    if custid.nil? && publication.nil?
      raise ArgumentError.new('Parameters are nil. Aborting...')
    elsif !custid.nil? && !publication.nil?
      suburl << "&custid=" + custid.to_s + "&" + "publication=" + publication.to_s
    end

    call_target_url(BASE_URL + admin_url + suburl)
  
  end
  
  # list_publications
  def list_publications

    suburl = "&action=list_publications" 
  
    call_target_url(BASE_URL + admin_url + suburl) 
  
  end#list_publications
  
  # add_publication
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

    call_target_url(BASE_URL + admin_url + suburl)
   
  end

end 