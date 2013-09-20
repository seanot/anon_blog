get '/' do
  erb :index
end

get '/new_post' do
  erb :new_post
end

get '/posts_list' do
  @posts = Post.all
  erb :posts_list
end

get '/post/:id' do
  @post = Post.find(params[:id])
  @tags = @post.tags
  erb :post
end

get '/post/:id/edit' do
  @post = Post.find(params[:id])
  erb :edit_post
end

#=====POST===============

post '/post' do
  post = Post.create(title: params[:title], body: params[:body])

  tags = params[:tags].gsub(',', '').split(/ /)
  tags.each do |tag|
    add_tag = Tag.find_or_create_by_name(name: tag)
    PostTag.create(tag_id: add_tag.id, post_id: post.id)
  end

  redirect to('/')
end

post '/post/:id' do
  @post = Post.find(params[:id])
  if @post.update_attributes(title: params[:title], body: params[:body])
    # tags = params[:tags].gsub(',', '').split(/ /)
    # tags.each do |tag|
    #   add_tag = Tag.find_or_create_by_name(name: tag)
    #   PostTag.update_attributes(tag_id: add_tag.id, post_id: @post.id)
    # end
    redirect to('/')
  else
    erb :edit_post
  end
end

post '/post/:id/delete' do
  @post = Post.find(params[:id])
  @post.destroy
  redirect to('/')
end
