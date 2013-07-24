require 'spec_helper'

describe UsersController do

  let(:user){FactoryGirl.create(:user)}

  context "POST update" do

    it "should edit name nickname && password" do
      post :update, {id: user.id, user: {name: 'DHH', nickname: 'D', 
                            password: 777777, password_confirmation: 777777}}

      auser = user.reload
      expect(auser.reload.name).to eq('DHH')
      expect(auser.nickname).to eq('D')
      expect(auser.authenticate(777777)).to be_true
    end

    it "should not update password when password is """ do
      post :update, {id: user.id, user:{ password: '', password_confirmation: ''}}

      auser = user.reload
      expect(user.reload.authenticate(666666)).to be_true
    end

    it "should not update password when password and password_confirmation is not match" do
      post :update, {id: user.id, user:{ password: '666666', password_confirmation: '777777'}}

      auser = user.reload
      expect(auser.authenticate(666666)).to be_true
    end

  end

end
