require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }

  context 'when user is logged in' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "GET #created" do
      it "returns http success" do
        get :created, params: { user_id: user.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #positions_taken" do
      it "returns http success" do
        get :positions_taken, params: { user_id: user.id }
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'when user is not logged in' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end

    describe "GET #created" do
      it "returns http found" do
        get :created, params: { user_id: user.id }
        expect(response).to have_http_status(:found)
      end
    end

    describe "GET #positions_taken" do
      it "returns http found" do
        get :positions_taken, params: { user_id: user.id }
        expect(response).to have_http_status(:found)
      end
    end
  end

end
