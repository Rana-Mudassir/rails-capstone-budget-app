require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:group) { create(:group) }

    it 'redirects to group entities path' do
      get :show, params: { id: group.id }
      expect(response).to redirect_to(group_entities_path(group))
    end
  end

  describe 'GET #new' do
    it 'assigns a new group to @group' do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new group' do
        expect do
          post :create, params: { group: attributes_for(:group) }
        end.to change(Group, :count).by(1)
      end

      it 'associates the new group with the current user' do
        post :create, params: { group: attributes_for(:group) }
        expect(assigns(:group).user).to eq(user)
      end

      it 'redirects to the groups index page' do
        post :create, params: { group: attributes_for(:group) }
        expect(response).to redirect_to(groups_url)
      end
    end

    context 'with invalid params' do
      it 'does not create a new group' do
        expect do
          post :create, params: { group: attributes_for(:group, name: nil) }
        end.not_to change(Group, :count)
      end

      it 're-renders the new template' do
        post :create, params: { group: attributes_for(:group, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end
end
