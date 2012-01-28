require File.dirname(__FILE__) + '/../spec_helper'

describe PlayerRound do
  it "should be valid" do
    PlayerRound.new.should be_valid
  end
end
