class Collection
  include Enumerable
  attr_reader :songs

  def initialize(songs)
    @songs = songs
  end

  def self.parse(text)
    new text.split("\n").map(&:strip).each_slice(4)
    .map { |song| Song.new(song[0], song[1], song[2]) }
  end

  def filter(criterion)
    Collection.new @songs.select(&criterion.proc)
  end

  def adjoin(other)
    Collection.new @songs | other.songs
  end

  [:name, :artist, :album,].each do |attribute|
    define_method "#{attribute}s" do
      @songs.map { |song| song.public_send(attribute) }.uniq
    end
  end

  def each
    @songs.each { |song| yield song }
  end

  def to_s
    @songs.join("\n")
  end
end

class Song < Struct.new :name, :artist, :album
  def to_s
    "#{name}\n#{artist}\n#{album}\n"
  end
end

class Criteria
  attr_reader :proc

  def initialize(&proc)
    @proc = proc
  end

  def & other
    Criteria.new { |value| @proc.call(value) and other.proc.call(value) }
  end

  def | other
    Criteria.new { |value| @proc.call(value) or other.proc.call(value) }
  end

  def !
    Criteria.new { |value| not @proc.call(value) }
  end

  class << self
    [:name, :artist, :album,].each do |attribute|
      define_method attribute do |value|
        new { |song| song.public_send(attribute) == value }
      end
    end
  end
end
