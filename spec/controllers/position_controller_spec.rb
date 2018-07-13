require 'rails_helper'

RSpec.describe PositionController, type: :controller do
  let(:user) { create(:user) }
  let(:position_one) { create(:position, id: 1) }
  let(:position_two) { create(:position, id: 2) }
  let(:topics) { [create(:topic, position_one: position_one.id, position_two: position_two.id)] }

  before do
    allow(Topic).to receive(:where).and_return(topics)
  end

  context 'when user is logged in' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "POST #select" do
      it "returns http success" do
        post :select, params: { position_id: position_one.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "DELETE #deselect" do
      it "returns http success" do
        delete :deselect, params: { position_id: position_one.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #almost" do
      it "returns http success" do
        get :almost, params: { position_id: position_one.id }
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'when user is not logged in' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end

    describe "POST #select" do
      it "returns http found" do
        post :select, params: { position_id: position_one.id }
        expect(response).to have_http_status(:found)
      end
    end

    describe "DELETE #deselect" do
      it "returns http found" do
        delete :deselect, params: { position_id: position_one.id }
        expect(response).to have_http_status(:found)
      end
    end

    describe "GET #almost" do
      it "returns http found" do
        get :almost, params: { position_id: position_one.id }
        expect(response).to have_http_status(:found)
      end
    end
  end

end
