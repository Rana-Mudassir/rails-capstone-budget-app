require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    group = Group.new(name: 'Example Group', icon: 'icon.png')
    group.user = user
    expect(group).to be_valid
  end

  it 'is not valid without a name' do
    group = Group.new
    group.user = user
    expect(group).not_to be_valid
  end

  it 'belongs to a user' do
    group = Group.new(name: 'Example Group')
    group.user = user
    expect(group.user).to eq(user)
  end

  it 'has and belongs to many entities' do
    group = Group.new(name: 'Example Group')
    group.user = user
    expect(group.entities).to be_empty
  end
end
