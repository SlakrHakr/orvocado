class PositionController < ApplicationController
  def select
    position_id = params[:position_id].to_i
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first

    store_location_for(:user, topic_path(topic.id))
    authenticate_user!

    if (topic.position_one.id == position_id) && (topic.position_two.selected?)
      UserPosition.where(user_id: current_user.id, position_id: topic.position_two.id).destroy_all
      reasons = Reason.where(user_id: current_user.id, position_id: topic.position_two.id)
      reasons.each do |reason|
        UserReasonAgreement.where(user_id: current_user.id, reason_id: reason.id).destroy_all
        agrees_with_reason = UserReasonAgreement.where(reason_id: reason.id)
        if agrees_with_reason.empty?
          reason.destroy
        else
          reason.user_id = agrees_with_reason[0].user.id
          reason.save
        end
      end
    elsif (topic.position_two.id == position_id) && (topic.position_one.selected?)
      UserPosition.where(user_id: current_user.id, position_id: topic.position_one.id).destroy_all
      reasons = Reason.where(user_id: current_user.id, position_id: topic.position_one.id)
      reasons.each do |reason|
        UserReasonAgreement.where(user_id: current_user.id, reason_id: reason.id).destroy_all
        agrees_with_reason = UserReasonAgreement.where(reason_id: reason.id)
        if agrees_with_reason.empty?
          reason.destroy
        else
          reason.user_id = agrees_with_reason[0].user.id
          reason.save
        end
      end
    end

    UserPosition.create(user_id: current_user.id, position_id: position_id)

    topic.interaction_count += 1
    topic.save

    render json: topic
  end

  def deselect
    position_id = params[:position_id].to_i
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first

    store_location_for(:user, topic_path(topic.id))
    authenticate_user!

    UserPosition.where(user_id: current_user.id, position_id: position_id).destroy_all
    reasons = Reason.where(user_id: current_user.id, position_id: position_id)
    reasons.each do |reason|
      UserReasonAgreement.where(user_id: current_user.id, reason_id: reason.id).destroy_all
      agrees_with_reason = UserReasonAgreement.where(reason_id: reason.id)
      if agrees_with_reason.empty?
        reason.destroy
      else
        reason.user_id = agrees_with_reason[0].user.id
        reason.save
      end
    end
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first

    render json: topic
  end

  def almost
    position_id = params[:position_id].to_i
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first

    store_location_for(:user, topic_path(topic.id))
    authenticate_user!

    position = Position.find(position_id)
    render partial: '/topics/topic_almost_position', locals: { topic: topic, position: position }
  end
end
