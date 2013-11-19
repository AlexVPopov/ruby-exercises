require 'spec_helper'

describe "Bitmap" do
  bitmap1 = Bitmap.new [1, 10, 100], 3
  bitmap2 = Bitmap.new [1, 10, 100], 1
  bitmap3 = Bitmap.new [1, 10, 100]
  bitmap4 = Bitmap.new [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 4

  it 'works with optional arguments' do
    expect(bitmap1.to_s).to eq ".......#....#.#..##..#.."
    expect(bitmap2.to_s).to eq ".......#\n....#.#.\n.##..#.."
    expect(bitmap4.to_s).to eq ".......#......#.......##.....#..\n.....#.#.....##......###....#...\n....#..#....#.#.....#.##....##.."
  end

  it 'works without an optional argument' do
    expect(bitmap3.to_s).to eq ".......#....#.#..##..#.."
  end
end