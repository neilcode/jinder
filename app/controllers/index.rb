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

get '/login' do #<-- login with LinkedIn
	client_id = ENV['CLIENT_ID']
	redirect = ENV['REDIRECT_URI']
	scope = "r_fullprofile%20r_network%20r_emailaddress"
	state = ENV['STATE']

	uri = "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=#{client_id}&scope=#{scope}&state=#{state}&redirect_uri=#{redirect}"
	#HTTParty.post(uri, :query => { :email => "" })      ????????? maybe no hash needed since i interpolated strings in URI?
	
	response = HTTParty.post(uri)
	p response
end

