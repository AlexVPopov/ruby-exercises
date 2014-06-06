require 'spec_helper'

describe SumSquareDifference do
  it 'shows the correct sum of the first hundred natural numbers' do
    expect(SumSquareDifference.sum_difference(100)).to eq 25164150
  end
end