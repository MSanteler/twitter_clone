describe User do

  before(:each) { @user = FactoryBot.create(:user, email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  describe "followings and followers" do
    before do
      @followed_user = FactoryBot.create(:user)
      Follow.create(user: @user, followed: @followed_user)
    end
    it "returns followed users" do
      expect(@user.followings).to include(@followed_user)
      expect(@followed_user.followers).to include(@user)
    end
  end

end
