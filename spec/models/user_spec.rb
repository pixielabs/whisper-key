require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.create :user
  end

  describe "#destroy" do
    it "should not delete the user" do
      expect{@user.destroy}.to_not change{User.count}
    end
  end

end
