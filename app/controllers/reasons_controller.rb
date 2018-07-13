class ReasonsController < ApplicationController
  def index
    topic_id = params[:topic_id].to_i
    topic = Topic.find(topic_id)

    render partial: '/topics/reasons/reasons_content', locals: { topic: topic }
  end

  def create
    authenticate_user!

    description = params[:reason]
    render plain: 'A reason for this position is required.', status: :bad_request and return unless description.present?

    position_id = params[:position_id].to_i
    topic = Topic.where("position_one = ? or position_two = ?", position_id, position_id).first

    store_location_for(:user, topic_path(topic.id))

    if description =~ /{"reasonId": [0-9]+}/
      match_data = /{"reasonId": ([0-9]+)}/.match description
      reason_id = match_data[1].to_i
      reason = Reason.find(reason_id)
      reason.score += 1
      UserReasonAgreement.create(user_id: current_user.id, reason_id: reason_id)
      reason.save
    else
      reason = Reason.create(position_id: position_id, description: description, user_id: current_user.id, score: 1)
      UserReasonAgreement.create(user_id: current_user.id, reason_id: reason.id)
    end

    render json: reason
  end

  def agree
    authenticate_user!

    agree = ActiveModel::Type::Boolean.new.cast(params[:agree])
    reason_id = params[:reason_id].to_i
    reason = Reason.find(reason_id)

    if agree
      reason.score += 1
      UserReasonAgreement.create(user_id: current_user.id, reason_id: reason_id)
    else
      reason.score -= 1
      UserReasonAgreement.where(user_id: current_user.id, reason_id: reason_id).destroy_all
    end

    reason.save
    render json: reason
  end
end
