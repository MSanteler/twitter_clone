include Warden::Test::Helpers
Warden.test_mode!

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

  context "when logged in" do
    before do
      @user = FactoryBot.create(:user)
      login_as(@user, :scope => :user)
      visit root_path
    end
    # Scenario: Visit the home page
    #   Given I am signed in
    #   Then I should see my profile card
    scenario 'user sees profile card' do
      expect(page).to have_content @user.name
      expect(page).to have_content @user.email
    end

    context "when user has follows with tweets" do
      before do
        @followed_user = FactoryBot.create(:user)
        @tweet = FactoryBot.create(:tweet, user: @followed_user)
        visit root_path
      end
      scenario "users sees tweets of his followed users" do
        expect(page).to have_content @tweet.content
      end
    end
  end


end
