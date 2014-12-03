require 'pry'

get '/' do 
	erb :index
end

get '/test' do 
	p linkedin("http://www.google.com")
	redirect '/'
end

get '/users/new' do
	erb :create
end

post '/users' do 
	p params[:user]
	redirect '/'
end

get '/linkedin' do #<-- login with LinkedIn
	client_id = ENV['CLIENT_ID']
	redirect = ENV['REDIRECT_URI']
	scope = "r_fullprofile%20r_network%20r_emailaddress"
	state = ENV['STATE']
	linkedin_oauth = "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=#{client_id}&scope=#{scope}&state=#{state}&redirect_uri=#{redirect}"
	redirect linkedin_oauth #=> This will send us to GET '/logged_in' when done.
end

get '/logged_in' do
	client_id = ENV['CLIENT_ID']
	redirect = ENV['REDIRECT_URI']
	scope = "r_fullprofile%20r_network%20r_emailaddress"
	state = ENV['STATE']

	token_uri = "https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code&code=#{params["code"]}&redirect_uri=#{redirect}&client_id=#{client_id}&client_secret=#{ENV['SECRET_KEY']}"
	token_response = HTTParty.post(token_uri)	
	token = JSON.parse(token_response.body)
	#puts token

	# HTTParty.post('localhost:9393/users/new', :params => {token: token})
	HTTParty.post('http://localhost:9393/users/new', :query => {token: token})
	#erb :jobs
end

post '/users/new' do
	#we need to pull info from the user's linkedIn account and use it to create a user in our db.
	token = params[:token][:access_token]
	new_user_email = Crack::XML.parse(HTTParty.get("https://api.linkedin.com/v1/people/~:(email-address)?oauth2_access_token=#{token}").body)
	userdata = Crack::XML.parse(HTTParty.get("https://api.linkedin.com/v1/people/~?oauth2_access_token=#{token}").body)
	#isolate the email from the XML hash
	new_user_email = new_user_email["person"]["email_address"]
	profile = /id=(\d+)/.match(userdata["person"]["site_standard_profile_request"]["url"])[1]
	infohash = {
		name: userdata["person"]["first_name"] + " " + userdata["person"]["last_name"],
		headline: userdata["person"]["headline"],
		linked_in_profile_id: profile
	}

	binding.pry

end

