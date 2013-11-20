require 'spec_helper'

describe "Magic Square" do
  let (:magic_square) { [[2, 7, 6], [9, 5, 1], [4, 3, 8]] }
  let (:same_lines) do
    [[1, 2, 3, 4],
    [1, 2, 3, 4],
    [1, 2, 3, 4],
    [1, 2, 3, 4]]
  end

  it "raises an error if given incorrect argument" do
    expect { magic_square?("square") }.to raise_error ArgumentError
    expect { magic_square?([1, 2, 3]) }.to raise_error ArgumentError
  end

  it "does not raise an error if given argument is array of arrays" do
    expect { magic_square?(magic_square)  }.not_to raise_error
  end

  it 'returns true if square is magic' do
    expect(magic_square?(magic_square)).to eq true
  end

  it 'returns falls if square is not magic' do
    expect(magic_square?(same_lines)).to eq false
  end
end
