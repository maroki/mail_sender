require 'rails_helper'

RSpec.describe GamesController, type: :controller do

  describe "GET new" do

    context 'if try to make new game' do
      it 'open form' do
        get :new

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('text/html')
      end
    end
  end

  describe "POST create" do

    context 'if set valid params' do
      before do
        @params = {
          game: {
            name: 'Name', send_from: 'email@example.com'
          }
        }
      end

      it 'create game' do
        post :create, params: @params

        expect(response).to have_http_status(:redirect)
        expect(response.content_type).to eq('text/html')
        expect(Game.count).to eq 1
      end
    end

    context 'if set not valid params' do
      before do
        @params = {
          game: { name: 'Name' }
        }
      end

      it 'not create game' do
        post :create, params: @params

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('text/html')
        expect(Game.count).to eq 0
      end
    end
  end


  describe "GET show" do

    let(:game) { FactoryGirl.create(:game) }

    context 'if game exist in db' do
      it 'get game' do
        get :show, params: { id: game.id }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('text/html')
      end
    end

    context 'if game not exist in db' do
      it 'get 404 error' do
        expect { get :show, params: { id: -game.id } }.to raise_exception ActionController::RoutingError
      end
    end
  end

  describe "GET edit" do
    let(:game) { FactoryGirl.create(:game) }

    context 'if try to edit game' do
      it 'open edit form' do
        get :edit, params: { id: game.id}

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('text/html')
      end
    end
  end

  describe "PATCH update" do
    let!(:game) { FactoryGirl.create(:game) }

    context 'if set correct values' do
      before do
        @params = {
          game: {
            name: 'Name'
          }
        }
      end

      it 'update game' do
        patch :update, params: @params.merge({ id: game.id })

        expect(response).to have_http_status(:redirect)
        expect(response.content_type).to eq('text/html')
        expect(Game.count).to eq 1
        expect(Game.first.name).to eq 'Name'
      end
    end

    context 'if set incorrect values' do
      before do
        @params = {
          game: {
            name: ''
          }
        }
      end

      it 'not update game' do
        patch :update, params: @params.merge({ id: game.id })

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('text/html')
        expect(Game.count).to eq 1
        expect(Game.first.name).not_to eq ''
      end
    end
  end

  describe "DELETE destroy" do
    let!(:game) { FactoryGirl.create(:game) }

    context 'if set valid params' do

      it 'game wil be deleted' do
        delete :destroy, params: { id: game.id }

        expect(response).to have_http_status(:redirect)
        expect(response.content_type).to eq('text/html')
        expect(Game.count).to eq 0
      end
    end

    context 'if try to delete non existent record' do
      it 'get 404 error' do
        expect { delete :destroy, params: { id: -game.id } }.to raise_exception ActionController::RoutingError
      end
    end
  end

end
