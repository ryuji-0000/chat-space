require 'rails_helper'

describe MessagesController do
  let(:user) { create(:user) }
  let(:group) { create(:group) }

  describe 'GET#index' do

    context 'log in' do
      before do
        # login user
        # # @request.env['devise.mapping'] = Devise.mappings[:user]
        sign_in user
        get :index, params: { group_id: group.id }
      end

      it "assigns the requested group to @group" do
        expect(assigns(:group)).to eq group
      end

      it "assigns a new message to @message" do
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "renders the :index template" do
        expect(response).to render_template :index
      end
    end

    context 'not log in' do
      before do
        get :index, params: { group_id: group.id }
      end

      it "redirects to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST#create' do
    let(:params) { {message: attributes_for(:message), group_id: group.id, user_id: user.id } }

    context 'log in' do
      before do
        sign_in user
        # login user
      end

      context 'succeed in saving' do
        subject {
          post :create,
          params: params
        }

        it "saves the new message" do
          expect{ subject }.to change(Message, :count).by(1)
        end

        it "redirect_to group_messages_path(@group)" do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context 'fail in saving' do
        let(:invalid_params) { {message: attributes_for(:message, text: nil, image: nil), group_id: group.id, user_id: user.id } }
        subject {
          post :create,
          params: invalid_params
        }

        it "can't save the new message" do
          expect{ subject }.not_to change(Message, :count)
        end

        it "renders the :index template" do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'not log in' do
      before do
        post :create, params: params
      end

      it "redirects to new_user_session_path" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
