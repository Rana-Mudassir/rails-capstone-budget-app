require 'rails_helper'

RSpec.describe Entity, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    entity = Entity.new(name: 'Example Entity', amount: 100)
    entity.user = user
    expect(entity).to be_valid
  end

  it 'is not valid without a name' do
    entity = Entity.new(amount: 100)
    entity.user = user
    expect(entity).not_to be_valid
  end

  it 'is not valid without an amount' do
    entity = Entity.new(name: 'Example Entity')
    entity.user = user
    expect(entity).not_to be_valid
  end

  it 'belongs to a user' do
    entity = Entity.new(name: 'Example Entity', amount: 100)
    entity.user = user
    expect(entity.user).to eq(user)
  end

  it 'has and belongs to many categories' do
    entity = Entity.new(name: 'Example Entity', amount: 100)
    entity.user = user
    expect(entity.groups).to be_empty
  end
end
