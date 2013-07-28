require 'spec_helper'

describe UsersController do

  let(:user){FactoryGirl.create(:user)}

  context "POST update" do

    it "should edit name nickname && password" do
      post :update, {id: user.id, user: {nickname: 'D', 
                                         password: 777777, 
                                         password_confirmation: 777777, 
                                         current_password: 666666}}

      auser = user.reload
      expect(auser.nickname).to eq('D')
      expect(auser.authenticate(777777)).to be_true
    end

    it "should not update anything when current password is not correct" do
      post :update, {id: user.id, user: {nickname: 'DHH', 
                                         current_password: 666666}}
      expect(user.reload.nickname).to eq('DHH')
    end

    it "should not update password when password is """ do
      post :update, {id: user.id, user:{ password: '', password_confirmation: '', current_password: 666666}}

      auser = user.reload
      expect(user.reload.authenticate(666666)).to be_true
    end

    it "should not update password when password and password_confirmation is not match" do
      post :update, {id: user.id, user:{ password: '666666', 
                                         password_confirmation: '777777', 
                                         current_password: 666666}}

      auser = user.reload
      expect(auser.authenticate(666666)).to be_true
    end

  end

end
