require 'rails_helper'

RSpec.describe MailingsController, type: :controller do

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
      let(:game) { FactoryGirl.create(:game) }
      before do
        @params = {
          mailing_template: {
            subject: 'Subject', text: 'Text', planing_start_time_at: Time.now, game_id: game.id
          }
        }
      end

      it 'create mailing_template' do
        post :create, params: @params

        expect(response).to have_http_status(:redirect)
        expect(response.content_type).to eq('text/html')
        expect(MailingTemplate.count).to eq 1
      end
    end

    context 'if set not valid params' do
      before do
        @params = {
          mailing_template: { subject: 'Subject' }
        }
      end

      it 'not create mailing_template' do
        post :create, params: @params

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('text/html')
        expect(MailingTemplate.count).to eq 0
      end
    end
  end


  describe "GET show" do

    let(:mailing_template) { FactoryGirl.create(:mailing_template) }

    context 'if mailing_template exist in db' do
      it 'get mailing_template' do
        get :show, params: { id: mailing_template.id }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('text/html')
      end
    end

    context 'if mailing_template not exist in db' do
      it 'get 404 error' do
        expect { get :show, params: { id: -mailing_template.id } }.to raise_exception ActionController::RoutingError
      end
    end
  end

  describe "GET edit" do
    let(:mailing_template) { FactoryGirl.create(:mailing_template) }

    context 'if try to edit mailing_template' do
      it 'open edit form' do
        get :edit, params: { id: mailing_template.id}

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('text/html')
      end
    end
  end

  describe "PATCH update" do
    let!(:mailing_template) { FactoryGirl.create(:mailing_template) }

    context 'if set correct values' do
      before do
        @params = {
          mailing_template: {
            subject: 'Name'
          }
        }
      end

      it 'update mailing_template' do
        patch :update, params: @params.merge({ id: mailing_template.id })

        expect(response).to have_http_status(:redirect)
        expect(response.content_type).to eq('text/html')
        expect(MailingTemplate.count).to eq 1
        expect(MailingTemplate.first.subject).to eq 'Name'
      end
    end

    context 'if set incorrect values' do
      before do
        @params = {
          mailing_template: {
            text: ''
          }
        }
      end

      it 'not update mailing_template' do
        patch :update, params: @params.merge({ id: mailing_template.id })

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('text/html')
        expect(MailingTemplate.count).to eq 1
        expect(MailingTemplate.first.text).not_to eq ''
      end
    end
  end

  describe "DELETE destroy" do

    context 'if set valid params' do
      let!(:mailing_template) { FactoryGirl.create(:mailing_template) }

      it 'mailing_template wil be deleted' do
        delete :destroy, params: { id: mailing_template.id }

        expect(response).to have_http_status(:redirect)
        expect(response.content_type).to eq('text/html')
        expect(MailingTemplate.count).to eq 0
      end
    end

    context 'if try to delete non existent record' do
      it 'get 404 error' do
        expect { delete :destroy, params: { id: -1 } }.to raise_exception ActionController::RoutingError
      end
    end

    context 'if try to delete mailing in progress' do
      let!(:mailing_template) { FactoryGirl.create(:mailing_template) }

      before { mailing_template.start! }

      it 'get 404 error' do
        delete :destroy, params: { id: mailing_template.id }

        expect(response).to have_http_status(:redirect)
        expect(response.content_type).to eq('text/html')
        expect(MailingTemplate.count).to eq 1
      end
    end
  end
end
