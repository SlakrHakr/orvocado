require 'rails_helper'

RSpec.describe PositionController, type: :controller do

  describe "GET #select" do
    it "returns http success" do
      get :select
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #deselect" do
    it "returns http success" do
      get :deselect
      expect(response).to have_http_status(:success)
    end
  end

end
