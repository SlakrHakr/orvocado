class PositionController < ApplicationController
  def select
    position_id = params[:position_id].to_i
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first
    if (topic.position_one.id == position_id) && (topic.position_two.selected?)
      UserPosition.where(user_id: 1, position_id: topic.position_two.id).destroy_all
    elsif (topic.position_two.id == position_id) && (topic.position_one.selected?)
      UserPosition.where(user_id: 1, position_id: topic.position_one.id).destroy_all
    end

    UserPosition.create(user_id: 1, position_id: position_id)
    
    render json: topic
  end

  def deselect
    position_id = params[:position_id].to_i
    UserPosition.where(user_id: 1, position_id: position_id).destroy_all
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first

    render json: topic
  end
end
