class UsersController < ApplicationController
  def created
    authenticate_user!
    @topics = Topic.all.where(user_id: current_user.id).order('created_at DESC')
  end

  def positions_taken
    authenticate_user!
    user_positions = []
    UserPosition.all.where(user_id: current_user.id).each do |user_position|
      user_positions.push(user_position[:position_id])
    end
    @topics = Topic.all.where("position_one IN (?) or position_two IN (?)", user_positions, user_positions).order('created_at DESC')
  end
end
