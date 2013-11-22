require 'spec_helper'

describe "Robot" do
  it "should return an array of its marked positions" do
    expect(robot { move; move; mark; move; mark; }).to eq [2, 3]
    expect(robot(9) { move; mark; mark; move; move; mark; }).to eq [10, 10, 12]
    expect(robot(1000000) {}).to eq []
  end
end
