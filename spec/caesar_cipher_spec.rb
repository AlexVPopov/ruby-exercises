require 'spec_helper'

describe "Caesar" do

  latin_encrypter = Caesar.new 4
  dna_encrypter = Caesar.new 3, 'ACTG'

  it 'encrypts correctly' do
    expect(latin_encrypter.encrypt 'hello').to eq "lipps"
  end

  it 'encrypts correctly using DNA alphabet' do
    expect(dna_encrypter.encrypt 'ACCTGA').to eq "GAACTG"
  end

  it 'decrypts correctly' do
    expect(latin_encrypter.decrypt 'lipps').to eq 'hello'
  end

  it 'decrypts correctly using DNA alphabet' do
    expect(dna_encrypter.decrypt 'GAACTG').to eq 'ACCTGA'
  end
end
