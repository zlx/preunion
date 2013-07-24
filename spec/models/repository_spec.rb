require 'spec_helper'

describe Repository do

  it "#init_from_github" do
    Repository.init_from_github
    Repository.count.should == 1
  end
end
