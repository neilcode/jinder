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