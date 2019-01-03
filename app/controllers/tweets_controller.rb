class TweetsController < ApplicationController

  get '/tweets' do
    @is_logged_in = Helpers.is_logged_in?(session)
    if @is_logged_in != true
      redirect to '/login'
    else
      @user = Helpers.current_user(session)
      @tweets = Tweet.all
      erb :'/tweets/index'
    end
  end

  get '/tweets/new' do
    @is_logged_in = Helpers.is_logged_in?(session)
    if @is_logged_in != true
      redirect to '/login'
    else
      @user = Helpers.current_user(session)
      erb :'/tweets/new'
    end
  end

  post '/tweets/new' do
    @user = Helpers.current_user(session)
    if params[:content] == ""
      redirect to '/tweets/new'
    else
      @tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
      redirect to '/tweets'
    end
  end

  get '/tweets/:id' do
    @is_logged_in = Helpers.is_logged_in?(session)
    if @is_logged_in != true
      redirect to '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/edit'
  end

  post '/tweets/:id/edit' do
    @tweet = Tweet.find(params[:id])
    @tweet.content = params[:content]
    @tweet.save
    redirect to "/tweets/#{@tweet.id}"
  end

  delete '/tweets/delete/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    @tweet.save
  end
end
