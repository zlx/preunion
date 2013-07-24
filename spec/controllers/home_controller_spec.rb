require 'spec_helper'

describe HomeController do

  it "should render index" do
    get :index
    expect(response).to be_success
  end

end
