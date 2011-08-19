require 'spec_helper'

describe "For", 'with one list' do
  it 'returns the result of invoking the block once for each item in order' do
    items = (1..10)
    For({:x => items}){ x * x }.to_a.should == items.map {|x| x * x}
  end
end

describe "For", 'with multiple lists' do
  it 'results the result of invoking the block once for each combination list elements' do
    comp = For(
      { :x => [1,2] },
      { :y => [:a,:b] },
      { :z => [7] }
    ){ [x,y,z] }
    comp.to_a.should == [[1,:a,7], [1,:b,7], [2,:a,7], [2,:b,7]]
  end
end

describe "For", 'with conditions on sequences' do
  it 'filters the results by the conditions' do
    comp = For(
      { :x => (1..6), :where => lambda { x.even? } },
      { :y => (1..7), :where => lambda { x < y } }
    ){ [x, y] }
    comp.to_a.should == [
      [2, 3], [2, 4], [2, 5], [2, 6], [2, 7],
      [4, 5], [4, 6], [4, 7],
      [6, 7]
    ]
  end
end

describe "For", 'with a condition on comprehension' do
  it 'filters the results by the condition' do
    comp = For(
      {:x => (1..3)},
      {:y => (1..3)},
      :where => lambda { x < y }
    ){ [x, y] }
    comp.to_a.should == [[1,2], [1,3], [2, 3]]
  end
end
