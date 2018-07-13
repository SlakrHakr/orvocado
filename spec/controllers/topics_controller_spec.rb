require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let(:user) { create(:user) }
  let(:position_one) { create(:position, id: 1) }
  let(:position_two) { create(:position, id: 2) }
  let(:topic) { create(:topic, position_one: position_one.id, position_two: position_two.id) }

  before do
    allow(Topic).to receive(:find).with(topic.id).and_return(topic)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: topic.id }
      expect(response).to have_http_status(:success)
    end
  end

  context 'when user is logged in' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user selected a position' do
      describe "POST #create" do
        it "returns http found" do
          post :create, first_position: 'heres-the-first-position',
                        second_position: 'heres-the-second-position',
                        topic: 'heres-a-topic',
                        selected_position: 'left',
                        reason: 'heres-a-reason'
          expect(response).to have_http_status(:found)
        end
      end
    end

    context 'when user did not select a position' do
      describe "POST #create" do
        it "returns http bad_request" do
          post :create, first_position: 'heres-the-first-position',
                        second_position: 'heres-the-second-position',
                        topic: 'heres-a-topic'
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end

  context 'when user is not logged in' do
    before do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end

    describe "GET #new" do
      it "returns http found" do
        get :new
        expect(response).to have_http_status(:found)
      end
    end

    describe "POST #create" do
      it "returns http found" do
        post :create
        expect(response).to have_http_status(:found)
      end
    end
  end

end
