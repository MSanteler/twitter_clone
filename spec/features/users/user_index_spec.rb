include Warden::Test::Helpers
Warden.test_mode!

# Feature: User index page
#   As a user
#   I want to see a list of users
#   So I can see who has registered
feature 'User index page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  context "when signed in" do
    before do
      @user = FactoryBot.create(:user)
      login_as(@user, scope: :user)
    end
    # Scenario: User listed on index page
    #   Given I am signed in
    #   When I visit the user index page
    #   Then I see my own email address
    scenario 'user sees own email address' do
      visit users_path
      expect(page).to have_content @user.email
    end

    scenario 'user follows another user' do
      @another_user = FactoryBot.create(:user)
      visit follow_user_path(@another_user)
      expect(@user.followings).to include(@another_user)
    end

    context 'user is already following' do
      before do
        @another_user = FactoryBot.create(:user)
        Follow.create(user: @user, followed: @another_user)
      end

      scenario "user is already following another user" do
        expect(@user.followings).to include(@another_user)
      end

      scenario 'user unfollows another user' do
        visit unfollow_user_path(@another_user)
        expect(@user.followings).not_to include(@another_user)
      end

      scenario 'user unfollows another user' do
        visit follow_user_path(@user)
        expect(@user.followings).not_to include(@user)
        expect(page).to have_content("Error: You cannot follow yourself")
      end
    end

  end
end
