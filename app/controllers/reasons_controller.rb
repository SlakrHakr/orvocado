class ReasonsController < ApplicationController
  def create
    position_id = params[:position_id].to_i
    description = params[:reason]
    render json: Reason.create(position_id: position_id, description: description)
  end

  def destroy
  end
end
