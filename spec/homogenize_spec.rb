require "spec_helper"

describe "homogenize" do
  it "returns array of homogeneous arrays" do
    homogenize([1, :a, 2, :b, 3, :c]).should =~ [[1, 2, 3], [:a, :b, :c]]
    homogenize([:a, "Jimi", "Kurt", :b]).should =~ [[:a, :b], ["Jimi", "Kurt"]]
    homogenize([:a, "Kurt", :b]).should =~ [["Kurt"], [:a, :b]]
    homogenize([:a,32,:b,3,"gosho"]).should =~ [[:a, :b], [32,3],["gosho"]]
    homogenize([[],{},Hash.new(0),3,'gosho']).should =~ [[{},{}], [[]],[3],['gosho']]
    homogenize([1.3,1/3r,:b,3,Array.new]).should =~ [[:b], [1/3r], [1.3],[3],[[]]]
    homogenize([]).should =~ []
    homogenize([nil,[nil]]).should =~ [[nil],[[nil]]]
    homogenize([NilClass,Array]).should =~ [[NilClass,Array]]
  end
end