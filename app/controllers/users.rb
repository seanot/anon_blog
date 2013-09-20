get '/logout' do
  session.clear
  redirect to ('/')
end

get '/register' do
  erb :register
end

get '/users/:id/profile' do
  erb :user_profile
end

#=====POST========

post '/login' do
  email = params[:email]
  password = params[:password]
  @user = User.authenticate(email, password)

  if @user
    session[:user_id] = @user.id
    redirect to('/')
  else
    @error = "Login error, please try again"
    erb :index
  end
end

post '/register' do
  email = params[:email]
  password = params[:password]
  @user = User.create(email: email, password: password)
  session[:user_id] = @user.id
  redirect to("/users/#{@user.id}/profile")
end

post '/users/:id' do
  @user = User.find(params[:id])
  if @user.update_attributes(first_name: params[:first_name],
                              last_name: params[:last_name])
    redirect to('/')
  else
    erb :index
  end
end