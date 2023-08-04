require 'rails_helper'

RSpec.feature 'Groups', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  before do
    login_as(user, scope: :user)
  end

  describe 'Categories list index page' do
    before do
      @group1 = Group.create(name: 'Category 1', icon: 'icon1', user:)
      @group1 = Group.create(name: 'Category 2', icon: 'icon2', user:)
      visit groups_path
    end

    it 'displays a list of Categories with their names' do
      expect(page).to have_content('Category 1')
      expect(page).to have_content('Category 2')
    end

    it 'displays the Categories Icon' do
      expect(page).to have_selector("img[src*='icon1']")
      expect(page).to have_selector("img[src*='icon2']")
    end

    it 'shows the "Add Category" link for logged-in users' do
      expect(page).to have_link('Add new Category', href: new_group_path)
    end

    it 'navigates to the "Add new Category" page when "Add new Category" link is clicked' do
      click_link 'Add new Category'
      expect(current_path).to eq(new_group_path)
    end
  end
end
