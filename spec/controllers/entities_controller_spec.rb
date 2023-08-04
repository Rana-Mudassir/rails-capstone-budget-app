require 'rails_helper'

RSpec.describe EntitiesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group, user:) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index, params: { group_id: group.id }
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new entity to @entity' do
      get :new, params: { group_id: group.id }
      expect(assigns(:entity)).to be_a_new(Entity)
    end

    it 'renders the new template' do
      get :new, params: { group_id: group.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new entity' do
        expect do
          post :create, params: { group_id: group.id, entity: attributes_for(:entity, user:) }
        end.to change(Entity, :count).by(1)
      end

      it 'associates the new entity with the group' do
        post :create, params: { group_id: group.id, entity: attributes_for(:entity, user:) }
        expect(assigns(:entity).groups).to include(group)
      end

      it 'redirects to the index page of group entities' do
        post :create, params: { group_id: group.id, entity: attributes_for(:entity, user:) }
        expect(response).to redirect_to(group_entities_path(group_id: group.id))
      end
    end

    context 'with invalid params' do
      it 'does not create a new entity' do
        expect do
          post :create, params: { group_id: group.id, entity: attributes_for(:entity, user:, name: nil) }
        end.not_to change(Entity, :count)
      end

      it 're-renders the new template' do
        post :create, params: { group_id: group.id, entity: attributes_for(:entity, user:, name: nil) }
        expect(response).to render_template(:new)
      end
    end
  end
end
