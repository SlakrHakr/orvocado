class TopicsController < ApplicationController
  require 'open-uri'

  def index
    query = Topic.paginate(page: params[:page], per_page: 40)
    if params[:tags].present?
      query = query.joins( :tags ).where( :tags => {:name => params[:tags].split('+')} )
    end
    @topics = query.order('interaction_count DESC').order('created_at DESC')
    render json: @topics if File.extname(request.fullpath).present?
  end

  def show
  	@topic = Topic.find(params[:id].to_i)

    if request.xhr?
      render partial: '/topics/topic_content', locals: { topic: @topic }
    else
      topic = @topic.attributes
      topic['position_one'] = @topic.position_one.attributes
      topic['position_two'] = @topic.position_two.attributes
      topic['position_one']['selected_perc'] = @topic.position_one_perc
      topic['position_one']['reasons'] = @topic.position_one.reasons
      topic['position_two']['selected_perc'] = @topic.position_two_perc
      topic['position_two']['reasons'] = @topic.position_two.reasons
      render json: topic if File.extname(request.fullpath).present?
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
    topic = Topic.create(description: params[:topic], position_one: position_one.id, position_two: position_two.id, user_id: current_user.id)

    if params[:tags].present?
      params[:tags].each do |tag|
        Tag.create(topic_id: topic.id, name: tag)
      end
    end

    if (params[:selected_position] == 'left') || (params[:selected_position] == 'right')
      position = params[:selected_position] == 'left' ? position_one : position_two
      UserPosition.create(user_id: current_user.id, position_id: position.id)
      reason = Reason.create(position_id: position.id, description: params[:reason], user_id: current_user.id, score: 1)
      UserReasonAgreement.create(user_id: current_user.id, reason_id: reason.id)
    else
      render plain: 'Picking a side is required for topic submission.', status: :bad_request and return
    end

    redirect_to topic_path(topic.id)
  end
end
