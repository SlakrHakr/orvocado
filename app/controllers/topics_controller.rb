class TopicsController < ApplicationController

  def index
    # @topics = Topic.paginate(page: params[:page], per_page: 15).order('created_at DESC')
    @topics = Topic.all.order('created_at DESC')
  end

  def show
  	@topic = Topic.find(params[:id].to_i)

    if request.xhr?
      render partial: '/topics/topic_content', locals: { topic: @topic }
    end
  end

  def new
    authenticate_user!
    @tags = Tag.all
  end
end
