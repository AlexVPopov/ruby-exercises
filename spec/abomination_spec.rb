require 'spec_helper'

describe "Abomination" do

  a = Abomination.new 5, 'foo', [1, 2], :bar

  it 'responds to the methods of its objects' do
    expect(a.abs).to eq 5
    expect(a.gsub 'o', 'a').to eq 'faa'
    expect(a.join ', ').to eq '1, 2'
    expect(a.to_s).to eq '5'
    expect(a.length).to eq 3
  end

  it 'raises NoMethodError if none of its objects responds to a method' do |variable|
    expect{ a.foo }.to raise_error(NoMethodError)
  end

  it 'returns true if any of its objects is_a? particular class' do
    expect(a.is_a? Fixnum).to be(true)
    expect(a.is_a? String).to be(true)
    expect(a.is_a? Symbol).to be(true)
    expect(a.is_a? Abomination).to be(true)
    expect(a.is_a? Float).to be(false)
    expect(a.is_a? Hash).to be(false)
  end
end
