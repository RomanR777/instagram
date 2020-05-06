require 'rails_helper'

RSpec.feature "Signup", type: :feature do
  it 'user can sign up' do
    visit('/users/sign_up')
    expect(page).to have_selector(:link_or_button, 'Sign up')
    fill_in('Nickname', :with => 'user1')
    fill_in('Email', :with => 'test@test.com')
    fill_in('Password', :with => '1q2w3e4r')
    fill_in('Password confirmation', :with => '1q2w3e4r')
    click_on('Sign up')
    expect(page).to have_content('user1')
  end

  # it 'user can sign in' do
  #   User.create(nickname: 'user1', email: 'test@test.com', password: '1a2w3e4r')
  #   visit('/users/sign_in')
  #   expect(page).to have_selector(:link_or_button, 'Log in')
  #   fill_in('Email', :with => 'test@test.com')
  #   fill_in('Password', :with => '1q2w3e4r')
  #   click_on('Log in')
  #   expect(page).to have_content('user1')
  # end
end
