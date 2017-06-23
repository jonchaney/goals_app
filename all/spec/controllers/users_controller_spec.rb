require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "Get new" do

    it 'renders the new users template' do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe 'Post create' do

    it "validates that the password is at least 6 charcters long" do
      post :create , params: { user: { username: 'Nick Bacon', password: 'hello'} }
      assert_template('users/new')
      expect(flash[:errors]).to be_present
    end

    it "redirects user to homepage on success" do
      post :create, params: { user: {username: "Elliot", password: 'password'} }
      expect(response).to redirect_to(homepage)
    end

    it 'logs in the user' do
      post :create, params: { user: { username: "jon_chaney", password: "passedword" } }
      user = User.find_by_username("jon_chaney")

      expect(session[:session_token]).to eq(user.session_token)
    end

  end


end
