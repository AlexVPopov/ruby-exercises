require 'spec_helper'

d1 = Branch.new 10, 2
d2 = Branch.new 2, 10
d_bm = BinaryMobile.new d1, d2

e1 = Branch.new 2, 3
e2 = Branch.new 2, 4
e_bm = BinaryMobile.new e1, e2

bm = BinaryMobile.new Branch.new(10, 3), Branch.new(8, 4.2)
bm2 = BinaryMobile.new Branch.new(1, 2), Branch.new(2, 1)

b1 = Branch.new 2.5, d_bm
b2 = Branch.new 6, 5
b_bm = BinaryMobile.new b1, b2

c1 = Branch.new 5, 3.4
c2 = Branch.new 5, 3.4
c_bm = BinaryMobile.new c1, c2

a1 = Branch.new 1.2, b_bm
a2 = Branch.new 3, c_bm
a_bm = BinaryMobile.new a1, a2

describe "Binary Mobile" do
  it "'s balanced? method works as expected" do
    expect(d_bm.balanced?).to eq true
    expect(e_bm.balanced?).to eq false
    expect(bm.balanced?).to eq false
    expect(bm2.balanced?).to eq true
    expect(b_bm.balanced?).to eq true
    expect(c_bm.balanced?).to eq true
    expect(a_bm.balanced?).to eq true
  end

  it "'s weight method works as expected" do
    expect(d_bm.weight).to eq 12
    expect(e_bm.weight).to eq 7
    expect(bm.weight).to eq 7.2
    expect(b_bm.weight).to eq 17
    expect(c_bm.weight).to eq 6.8
    expect(a_bm.weight).to eq 23.8
  end
end

