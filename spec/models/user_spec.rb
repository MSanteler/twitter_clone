describe User do

  before(:each) { @user = FactoryBot.create(:user, email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  describe "followings and followers" do
    before do
      # @user follows @followed_user
      @followed_user = FactoryBot.create(:user)
      @user.follow(@followed_user)
    end
    it "returns followed users" do
      expect(@user.followings).to include(@followed_user)
      expect(@followed_user.followers).to include(@user)
    end
  end

  describe "#tweet_timeline" do
    let(:tweet_timeline) { @user.tweet_timeline.to_a }
    before do
      @followed_user = FactoryBot.create(:user)
      @user.follow(@followed_user)
      @older_tweet = FactoryBot.create(:tweet, user: @user, created_at: 1.day.ago)
      @newer_tweet = FactoryBot.create(:tweet, user: @followed_user, created_at: 1.hour.ago)
    end
    it "returns tweets of my followings as well as my own, in descending order" do
      expect(tweet_timeline).to eq([@newer_tweet, @older_tweet])
    end
  end

end
