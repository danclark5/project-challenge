require 'rails_helper'

describe 'Dog resource', type: :feature do
  let (:authenticated_user) { FactoryBot.create(:user) }
  let (:another_user) { FactoryBot.create(:user, email: 'another@example.com') }
  before do
    login_as(authenticated_user, :scope => :user)
  end

  it 'can create a profile' do
    visit new_dog_path
    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Image', 'spec/fixtures/images/speck.jpg'
    click_button 'Create Dog'
    expect(Dog.count).to eq(1)
  end

  it 'can edit a dog profile' do
    dog = create(:dog, user: authenticated_user)
    visit edit_dog_path(dog)
    fill_in 'Name', with: 'Speck'
    click_button 'Update Dog'
    expect(dog.reload.name).to eq('Speck')
  end

  it 'redirects when editing a another user\'s dog' do
    dog = create(:dog, user: another_user )
    visit edit_dog_path(dog)
    expect(page).to have_current_path(dogs_path)
    expect(find('#navigation')).to
    expect(page).to have_content 'Not authorized'
  end

  it 'can delete a dog profile' do
    dog = create(:dog, user:  authenticated_user)
    visit dog_path(dog)
    click_link "Delete #{dog.name}'s Profile"
    expect(Dog.count).to eq(0)
  end
end
