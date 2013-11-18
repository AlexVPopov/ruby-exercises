require 'spec_helper'

describe "Collection" do

  SONGS = <<END
Fields of Gold
Sting
Ten Summoner's Tales

Mad About You
Sting
The Soul Cages

Fields of Gold
Eva Cassidy
Live at Blues Alley

Autumn Leaves
Eva Cassidy
Live at Blues Alley

Autumn Leaves
Bill Evans
Portrait in Jazz

Brain of J.F.K
Pearl Jam
Yield

Jeremy
Pearl Jam
Ten

Come Away With Me
Norah Johnes
One

Acknowledgment
John Coltrane
A Love Supreme

Ruby, My Dear
Thelonious Monk
Mysterioso
END

  let(:collection) { Collection.parse(SONGS) }

  it 'has a custom to_s method' do
    expect(collection.to_s).to eq  <<-EOL
Fields of Gold
Sting
Ten Summoner's Tales

Mad About You
Sting
The Soul Cages

Fields of Gold
Eva Cassidy
Live at Blues Alley

Autumn Leaves
Eva Cassidy
Live at Blues Alley

Autumn Leaves
Bill Evans
Portrait in Jazz

Brain of J.F.K
Pearl Jam
Yield

Jeremy
Pearl Jam
Ten

Come Away With Me
Norah Johnes
One

Acknowledgment
John Coltrane
A Love Supreme

Ruby, My Dear
Thelonious Monk
Mysterioso
EOL
  end

  it "can find all the songs in the collection" do
    collection.names.should =~ [
      'Fields of Gold',
      'Mad About You',
      'Autumn Leaves',
      'Brain of J.F.K',
      'Jeremy',
      'Come Away With Me',
      'Acknowledgment',
      'Ruby, My Dear',
    ]
  end

  it "can find all the albums in the collection" do
    collection.albums.should =~ [
      "Ten Summoner's Tales",
      'The Soul Cages',
      'Live at Blues Alley',
      'Portrait in Jazz',
      'Yield',
      'Ten',
      'One',
      'A Love Supreme',
      'Mysterioso',
    ]
  end

  it "can find all the artists in the collection" do
    collection.artists.should =~ [
      'Sting',
      'Eva Cassidy',
      'Bill Evans',
      'Pearl Jam',
      'Norah Johnes',
      'John Coltrane',
      'Thelonious Monk',
    ]
  end

  it 'implements the Enumerable module' do
    collection.map { |song| song.name }.should =~ [
      'Fields of Gold',
      'Mad About You',
      'Fields of Gold',
      'Autumn Leaves',
      'Autumn Leaves',
      'Brain of J.F.K',
      'Jeremy',
      'Come Away With Me',
      'Acknowledgment',
      'Ruby, My Dear',
    ]
    collection.map { |song| song.artist }.should =~ [
      'Sting',
      'Sting',
      'Eva Cassidy',
      'Eva Cassidy',
      'Bill Evans',
      'Pearl Jam',
      'Pearl Jam',
      'Norah Johnes',
      'John Coltrane',
      'Thelonious Monk',
    ]
    collection.map { |song| song.album }.should =~ [
      "Ten Summoner's Tales",
      'The Soul Cages',
      'Live at Blues Alley',
      'Live at Blues Alley',
      'Portrait in Jazz',
      'Yield',
      'Ten',
      'One',
      'A Love Supreme',
      'Mysterioso',
    ]
  end

  it "can filter collection by name" do
    expect(collection.filter(Criteria.name 'Fields of Gold').artists).to eq [
      'Sting',
      'Eva Cassidy',
    ]
    expect(collection.filter(Criteria.name 'Autumn Leaves').albums).to eq [
      'Live at Blues Alley',
      'Portrait in Jazz',
    ]
    expect(collection.filter(Criteria.name 'Brain of J.F.K').songs).to eq [
      Song.new('Brain of J.F.K', 'Pearl Jam', 'Yield')]
  end

  it "can filter collection by artist" do
    expect(collection.filter(Criteria.artist 'Sting').songs.size).to eq 2
    expect(collection.filter(Criteria.artist 'Sting').songs).to eq [
      Song.new('Fields of Gold', 'Sting', 'Ten Summoner\'s Tales'),
      Song.new('Mad About You', 'Sting', 'The Soul Cages'),
    ]
  end

  it "can filter collection by album" do
    expect(collection.filter(Criteria.album 'Live at Blues Alley').songs.size).to eq 2
    expect(collection.filter(Criteria.album 'Live at Blues Alley').songs).to eq [
      Song.new('Fields of Gold', 'Eva Cassidy', 'Live at Blues Alley'),
      Song.new('Autumn Leaves', 'Eva Cassidy', 'Live at Blues Alley'),
    ]
  end

  it 'can filter by exclusion' do
    expect(collection.filter(!Criteria.artist('Sting')).to_s).to eq <<-EOL
Fields of Gold
Eva Cassidy
Live at Blues Alley

Autumn Leaves
Eva Cassidy
Live at Blues Alley

Autumn Leaves
Bill Evans
Portrait in Jazz

Brain of J.F.K
Pearl Jam
Yield

Jeremy
Pearl Jam
Ten

Come Away With Me
Norah Johnes
One

Acknowledgment
John Coltrane
A Love Supreme

Ruby, My Dear
Thelonious Monk
Mysterioso
EOL
  end

  it "supports a conjuction of filters" do
    filtered = collection.filter Criteria.artist('Sting') & Criteria.name('Fields of Gold')
    filtered.map(&:album).should eq ["Ten Summoner's Tales"]
  end

  it "can be adjoined with another collection" do
    sting    = collection.filter Criteria.artist('Sting')
    eva      = collection.filter Criteria.artist('Eva Cassidy')
    adjoined = sting.adjoin(eva)

    adjoined.count.should eq 4
    adjoined.names.should =~ [
      'Fields of Gold',
      'Autumn Leaves',
      'Mad About You',
    ]
  end
end