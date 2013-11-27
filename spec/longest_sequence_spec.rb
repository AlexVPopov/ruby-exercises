require 'spec_helper'

describe "String#longest_sequnece" do
  it 'returns the symbol(s) that form the longest sequence in a string' do
    expect('aab'.longest_sequence).to eq ['a']
    expect('abba'.longest_sequence).to eq ['b']
    expect('aaaaabbbbbddacccc'.longest_sequence).to eq ['a', 'b']
    expect('.....??????&gh'.longest_sequence).to eq ['?']
  end

  it "works with repeated sequence" do
    'aaaaabbbbbddacccc'.longest_sequence.should =~ ['b', 'a']
  end

  it "works with special symbol that needs to be escaped" do
    "\"".longest_sequence.should eq ["\""]
    '\''.longest_sequence.should eq ["'"]
    '\\'.longest_sequence.should eq ['\\']
  end

  it "works when there's not any longest sequence" do
    'asdfgh'.longest_sequence.should =~ ['a', 's', 'd', 'g', 'f', 'h']
  end

  it "works with empty string" do
    ''.longest_sequence.should eq []
  end

  it "works with utf-8 symbols" do
    'بسم'.longest_sequence.should =~ ['ب','س','م']
    '✓✓✓بسم'.longest_sequence.should eq ["\u2713".encode('utf-8')]
  end

  it "works with unprintable symbols" do
    ("дадада" + "\u2029".encode('utf-8') + "\u2029".encode('utf-8')).longest_sequence.should eq ["\u2029".encode('utf-8')]
    # U+2029 is the paragraph separator
  end
end