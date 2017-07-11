class ReasonsController < ApplicationController
  def index
    topic_id = params[:topic_id].to_i
    topic = Topic.find(topic_id)

    if request.xhr?
      render partial: '/topics/reasons/reasons_content', locals: { topic: topic }
    end
  end

  def create
    position_id = params[:position_id].to_i
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first

    store_location_for(:user, topic_path(topic.id))
    authenticate_user!

    description = params[:reason]
    render json: Reason.create(position_id: position_id, description: description, user_id: current_user.id)
  end

  def agree
    agree = ActiveModel::Type::Boolean.new.cast(params[:agree])
    reason_id = params[:reason_id].to_i
    reason = Reason.find(reason_id)

    if agree
      reason.score += 1
    else
      reason.score -= 1
    end

    reason.save
    render json: reason
  end
end
