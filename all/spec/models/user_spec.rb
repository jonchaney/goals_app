require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  let(:user1) { User.create(username: 'Dallas', password: 'password') }
  let(:nameless_user) { User.new(password: 'password') }


  it 'should not validate when name is missing' do
    expect(nameless_user.valid?).to be false
  end

  it 'should validate the presence of a name' do
    expect(user1.valid?).to be true
  end

  describe 'validations' do
    before(:each) do
      FactoryGirl.create(:user)
    end

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password_digest) }
  end

  describe 'password functions work' do

    pass = 'password'
    # hash = BCrypt::Password.create(pass)

    it 'converts password into a hash' do
      expect(user1.password_digest).to_not eq(pass)
    end

  end

  describe 'find by credentials' do
    let(:user1) { User.create(username: 'Dallas', password: 'password') }

    it 'finds a user' do
      user1
      expect(User.find_by_credentials('Dallas', 'password')).to be_truthy
    end



  end
  describe "session token" do
    it "assigns a session_token if one is not given" do
      jack = User.create(username: "jack_bruce", password: "abcdef")
      expect(jack.session_token).not_to be_nil
    end
  end


end
