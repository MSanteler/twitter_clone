include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'user sees own profile' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit user_path(user)
    expect(page).to have_content 'User'
    expect(page).to have_content user.email
  end

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I see an 'access denied' message
  context "When logged in and I visit anothers page" do
    let(:me) {FactoryBot.create(:user)}
    let(:user) {FactoryBot.create(:user, email: 'user@example.com')}
    let(:user2) {FactoryBot.create(:user, email: 'user2@example.com')}
    before do
      login_as(me, :scope => :user)
      Capybara.current_session.driver.header 'Referer', root_path
      @tweet = FactoryBot.create(:tweet, user: user)
    end
    scenario "I sees the others tweets" do
      visit user_path(user)
      expect(page).to have_content @tweet.content
    end
    scenario "I shouldn't see other's follower's tweets" do
      @user2_tweet = FactoryBot.create(:tweet, user: user2)
      user.follow(user2)
      visit user_path(user)
      expect(page).not_to have_content @user2_tweet.content
    end
  end

end
