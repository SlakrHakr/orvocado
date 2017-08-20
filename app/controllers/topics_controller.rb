class TopicsController < ApplicationController
  require 'open-uri'

  def index
    # query = Topic.paginate(page: params[:page], per_page: 40)
    # if params[:tags].present?
    #   query = query.joins( :tags ).where( :tags => {:name => params[:tags].split('+')} )
    # end
    # @topics = query.order('interaction_count DESC').order('created_at DESC')
    # render json: @topics if File.extname(request.fullpath).present?

    # puts "Position.create(description: 'Yes')"
    # puts "Position.create(description: 'No')"
    # puts "Topic.create(description: #{topic_description}, position_one: #{result_position_one.id}, position_two: #{result_position_two.id})"
    # puts "Tag.create(topic_id: #{result_topic.id}, name: #{tag})"
    # puts "Reason.create(position_id: #{result_position_one.id}, description: #{reason.gsub(/\[[0-9]+\]/, '')})"
    # puts "Reason.create(position_id: #{result_position_two.id}, description: #{reason.gsub(/\[[0-9]+\]/, '')})"

    seeds = ''
    Topic.all.each do |topic|
      seeds += "Position.create(description: '#{topic.position_one.description}')\n"
      seeds += "Position.create(description: '#{topic.position_two.description}')\n"
      seeds += "Topic.create(description: '#{topic.description}', position_one: #{topic.position_one.id}, position_two: #{topic.position_two.id})\n"
      topic.tags.each do |tag|
        seeds += "Tag.create(topic_id: #{topic.id}, name: '#{tag.name}')\n"
      end
      topic.position_one.reasons.each do |reason|
        seeds += "Reason.create(position_id: #{topic.position_one.id}, description: '#{reason.description.gsub('\'', '\\\\\'')}')\n"
      end
      topic.position_two.reasons.each do |reason|
        seeds += "Reason.create(position_id: #{topic.position_two.id}, description: '#{reason.description.gsub('\'', '\\\\\'')}')\n"
      end
      seeds += "\n"
    end

    File.open('awesome', 'w') { |file| file.write(seeds) }


    render text: seeds

  end

  def show
  	@topic = Topic.find(params[:id].to_i)

    if request.xhr?
      render partial: '/topics/topic_content', locals: { topic: @topic }
    else
      topic = @topic.attributes
      topic['position_one'] = @topic.position_one.attributes
      topic['position_two'] = @topic.position_two.attributes
      topic['position_one']['reasons'] = @topic.position_one.reasons
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
      raise "Picking a side is required for topic submission."
    end

    redirect_to topic_path(topic.id)
  end
end
