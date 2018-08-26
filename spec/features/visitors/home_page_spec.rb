# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home page' do

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "Sign in"
  scenario 'visit the home page' do
    visit root_path
    expect(page).to have_content 'Sign in'
  end

  # Scenario: Visit the home page
  #   Given I am signed in
  #   Then I should see my profile card
  scenario 'user sees profile card' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit root_path
    expect(page).to have_content "Profile Card"
    expect(page).to have_content user.email
  end

  # Scenario: Visit the home page
  #   Given I am signed in
  #   Then I should see some tweets
  scenario 'user sees profile card' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit root_path
    expect(page).to have_content "Some Tweet"
  end

end
