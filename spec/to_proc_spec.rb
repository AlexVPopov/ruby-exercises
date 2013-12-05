require 'spec_helper'

class Student
  attr_accessor :name, :points, :rank

  def initialize(name, points, rank)
    @name   = name
    @points = points
    @rank   = rank
  end
end

ivan   = Student.new 'Иван', 10, :second
mariya = Student.new 'Мария', 12, :first
neycho = Student.new 'Нейчо', 9, :third

students = [ivan, mariya, neycho]

describe "Array#to_proc" do
  it "works for a single element" do
    [:abs].to_proc.call(-42).should eq [42]
  end

  it 'should work for arrays with multiple elements' do |variable|
    expect([:points, :name].to_proc.call(ivan)).to eq [10, 'Иван']
  end

  it "should work with ampersand" do
    expect(students.map(&[:name, :rank])).to eq [['Иван', :second],
                                                 ['Мария', :first],
                                                 ['Нейчо', :third]]
  end
end

describe "Hash#to_proc" do
  let(:student) { Class.new { attr_accessor :points, :rank }.new }

  it "sets the properties of the object which correspond to its key value pairs" do
    {points: 0}.to_proc.call(student)
    student.points.should eq 0
  end

  it "should work with ampersand" do
    students.each &{points: 0, rank: :last}
    expect(students.map(&:points)).to eq [0, 0, 0]
    expect(students.map(&:rank)).to eq [:last, :last, :last]
  end
end
