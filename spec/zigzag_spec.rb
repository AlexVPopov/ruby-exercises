require "spec_helper"

describe "zig_zag" do
  it "works for n = 1" do
    zig_zag(1).should == [[1]]
  end

  it "works for n = 2" do
    zig_zag(2).should == [[1, 2], [4, 3]]
  end

  it "works for n = 3" do
    zig_zag(3).should == [[1, 2, 3], [6, 5, 4], [7, 8, 9]]
  end

  it "works for n = 4" do
    zig_zag(4).should == [[1,  2,  3,  4 ], [8,  7,  6,  5 ], [9,  10, 11, 12], [16, 15, 14, 13]]
  end
end
