helpers do

  def linkedin(url)
    # create the HTTP post request

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    #http.use_ssl = true
    request = Net::HTTP::Get.new(uri)

    #request["Authorization"] = oauth_header(request)

    # connect to the server and send the request
    response = http.request(request)
    return response
  end
	
end
