class ReasonsController < ApplicationController
  def create
    position_id = params[:position_id].to_i
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first

    store_location_for(:user, topic_path(topic.id))
    authenticate_user!

    description = params[:reason]
    render json: Reason.create(position_id: position_id, description: description, user_id: current_user.id)
  end

  def destroy
  end
end
