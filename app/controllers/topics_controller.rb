class TopicsController < ApplicationController

  def index
    query = Topic.paginate(page: params[:page], per_page: 40)
    if params[:tags].present?
      query = query.joins( :tags ).where( :tags => {:name => params[:tags].split('+')} )
    end
    @topics = query.order('created_at DESC')
  end

  def show
  	@topic = Topic.find(params[:id].to_i)

    if request.xhr?
      render partial: '/topics/topic_content', locals: { topic: @topic }
    end
  end

  def new
    authenticate_user!
    @tags = Tag.all.map { |tag| tag.name  }.uniq
  end

  def create
    authenticate_user!

    position_one = Position.create(description: params[:first_position])
    position_two = Position.create(description: params[:second_position])
    topic = Topic.create(description: params[:topic], position_one: position_one.id, position_two: position_two.id)

    if params[:tags].present?
      params[:tags].each do |tag|
        Tag.create(topic_id: topic.id, name: tag)
      end
    end

    if (params[:selected_position] == 'left') || (params[:selected_position] == 'right')
      position = params[:selected_position] == 'left' ? position_one : position_two
      UserPosition.create(user_id: current_user.id, position_id: position.id)
      Reason.create(position_id: position.id, description: params[:reason])
    else
      raise "Picking a side is required for topic submission."
    end

    redirect_to topic_path(topic.id)
  end
end
