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
  end

  # def almost_done
  #   topic_id = params[:topic_id].to_i
  #   position_id = params[:position_id].to_i
  #   render partial: 'topic', locals: { topic: Topic.find(topic_id), position_for_reason: Position.find(position_id) }
  # end
end
