include Warden::Test::Helpers
Warden.test_mode!

# Feature: Navigation links
#   As a visitor
#   I want to see navigation links
#   So I can find home, sign in, or sign up
feature 'Navigation links', :devise do

  # Scenario: View navigation links
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "home," "sign in," and "sign up"
  scenario 'view navigation links' do
    visit root_path
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'Sign up'
  end

  # Scenario: View navigation links
  #   Given I am a visitor
  #   Given I am signed in
  #   When I visit the home page
  #   Then I see "home," "moments," "notifications," "messages," and "sign up"
  #   Then I do not see "sign in" or "sign up"
  scenario 'view navigation links' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit root_path
    expect(page).to have_content 'Home'
    expect(page).to have_content 'Moments'
    expect(page).to have_content 'Notifications'
    expect(page).to have_content 'Messages'
    expect(page).to have_content 'Edit account'
    expect(page).to have_content 'Sign out'
    expect(page).to have_content 'Users'
    expect(page).not_to have_content 'Sign in'
    expect(page).not_to have_content 'Sign up'
  end

end
