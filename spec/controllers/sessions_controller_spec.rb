require 'spec_helper'

describe SessionsController do

  let(:user){FactoryGirl.create(:user)}

  context "GET auth" do
    before do
      User.stub(:find_or_create_from_auth_hash => user)
      controller.request.env['omniauth.auth'] = {'extra' => "auth_hash"}
    end

    it "should redirect_to edit_user_path(user)" do
      get :auth
      expect(response).to redirect_to(edit_user_path(user))
    end

    it "should set current_user when auth success" do
      get :auth
      expect(controller.current_user).to eq(user)
    end
  end

  context "POST create" do
    it "should redirect_to root_path when sign_in with default password" do
      post :create, {user: {email: user.email, password: 666666}}
      expect(response).to redirect_to(root_path)
    end

    it "should redirct_to new_session_path when sign in 777777" do
      post :create, {user: {email: user.email, password: 777777}}

      expect(response).to redirect_to(new_session_path)
    end
  end

  context "DELETE destroy" do

    it "should clear current_user and redirect_to root_path" do
      delete :destroy, {id: user.id}

      expect(response).to redirect_to(root_path)
      expect(controller.current_user).to be_nil
    end
  end

end
