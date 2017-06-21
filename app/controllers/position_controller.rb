class PositionController < ApplicationController
  def select
    position_id = params[:position_id].to_i
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first
    if (topic.position_one.id == position_id) && (topic.position_two.selected?)
      UserPosition.where(user_id: current_user.id, position_id: topic.position_two.id).destroy_all
    elsif (topic.position_two.id == position_id) && (topic.position_one.selected?)
      UserPosition.where(user_id: current_user.id, position_id: topic.position_one.id).destroy_all
    end

    UserPosition.create(user_id: current_user.id, position_id: position_id)

    render json: topic
  end

  def deselect
    position_id = params[:position_id].to_i
    UserPosition.where(user_id: current_user.id, position_id: position_id).destroy_all
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first

    render json: topic
  end

  def almost
    position_id = params[:position_id].to_i
    position = Position.find(position_id)
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first

    render partial: '/topics/topic_almost_position', locals: { topic: topic, position: position }
  end
end
