require File.dirname(__FILE__) + '/../spec_helper'

describe TeamRound do
  it "should be valid" do
    TeamRound.new.should be_valid
  end
end
