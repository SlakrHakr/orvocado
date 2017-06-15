class PositionController < ApplicationController
  def select
    redirect_to topics_path
  end

  def deselect
    redirect_to topics_path
  end
end
