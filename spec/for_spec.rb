require 'spec_helper'

describe "For", 'with one list' do
  it 'returns the result of invoking the block once for each item in order' do
    items = (1..10)
    For({:x => items}){ x * x }.to_a.should == items.map {|x| x * x}
  end
end

describe "For", 'with multiple lists' do
  it 'results the result of invoking the block once for each combination list elements' do
    For({:x => [1,2]}, {:y => [:a,:b]}){ [x,y]}.to_a.should == [[1,:a], [1,:b], [2, :a], [2, :b]]
  end
end
