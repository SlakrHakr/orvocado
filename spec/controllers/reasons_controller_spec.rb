require 'rails_helper'

RSpec.describe ReasonsController, type: :controller do
  let(:user) { create(:user) }
  let(:position_one) { create(:position, id: 1) }
  let(:position_two) { create(:position, id: 2) }
  let(:topic) { create(:topic, position_one: position_one.id, position_two: position_two.id) }
  let(:topics) { [topic] }
  let(:reason) { create(:reason) }

  before do
    allow(Topic).to receive(:find).and_return(topic)
    allow(Topic).to receive(:where).and_return(topics)
    allow(Reason).to receive(:find).and_return(reason)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, params: { topic_id: topic.id }
      expect(response).to have_http_status(:success)
    end
  end

  context 'when user is logged in' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    context 'when reason is provided' do
      context 'when custom reason is provided' do
        describe "POST #create" do
          it "returns http success" do
            post :create, params: { position_id: position_one.id, reason: 'heres-a-reason' }
            expect(response).to have_http_status(:success)
          end
        end
      end

      context 'when existing reason is selected' do
        describe "POST #create" do
          it "returns http success" do
            post :create, params: { position_id: position_one.id, reason: '{"reasonId": 1}' }
            expect(response).to have_http_status(:success)
          end
        end
      end
    end

    context 'when reason is not provided' do
      describe "POST #create" do
        it "returns http bad_request" do
          post :create, params: { position_id: position_one.id }
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    describe "POST #agree" do
      it "returns http success" do
        post :agree, params: { reason_id: reason.id }
        expect(response).to have_http_status(:success)
      end
    end
  end

  context 'when user is not logged in' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end

    describe "POST #create" do
      it "returns http found" do
        post :create, params: { position_id: position_one.id }
        expect(response).to have_http_status(:found)
      end
    end

    describe "POST #agree" do
      it "returns http found" do
        post :agree, params: { reason_id: reason.id }
        expect(response).to have_http_status(:found)
      end
    end
  end

end
