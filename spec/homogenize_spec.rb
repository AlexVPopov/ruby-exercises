require "spec_helper"

describe "homogenize" do
  it "returns array of homogeneous arrays" do
    homogenize([1, :a, 2, :b, 3, :c]).should =~ [[1, 2, 3], [:a, :b, :c]]
    homogenize([:a, "Jimi", "Kurt", :b]).should =~ [[:a, :b], ["Jimi", "Kurt"]]
    homogenize([:a, "Kurt", :b]).should =~ [["Kurt"], [:a, :b]]
    homogenize([:a,32,:b,3,"gosho"]).should =~ [[:a, :b], [32,3],["gosho"]]
    homogenize([[],{},Hash.new(0),3,'gosho']).should =~ [[{},{}], [[]],
                                                         [3],['gosho']]
    homogenize([1.3,1/3r,:b,3,Array.new]).should =~ [[:b], [1/3r],
                                                     [1.3],[3],[[]]]
    homogenize([]).should =~ []
    homogenize([nil,[nil]]).should =~ [[nil],[[nil]]]
    homogenize([NilClass,Array]).should =~ [[NilClass,Array]]
    anonymous_nil = ->() { nil }
    a_lot_of_items = [[1, 2], :a, [3, 4], 5, 6, :b, anonymous_nil]
    homogenize([1, :a, 2, :b, 3, :c, 1/2r]).should =~ [[1/2r], [1, 2, 3],
                                                       [:a, :b, :c]]
    homogenize(a_lot_of_items).should =~ [[5, 6], [:a, :b], [[1, 2],
                                          [3, 4]], [anonymous_nil]]
  end

  it "returns empty array when empty array given" do
    homogenize([]).should eq []
  end

  it "preserves the order" do
    homogenize([1, :a, 2, :b, 3, :c]).should     =~ [[1, 2, 3], [:a, :b, :c]]
    homogenize([1, :a, 2, :b, 3, :c]).should_not =~ [[1, 3, 2], [:c, :a, :b]]
  end
end