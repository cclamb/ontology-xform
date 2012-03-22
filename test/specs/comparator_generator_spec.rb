require 'rspec'

require_relative '../../lib/flounder/comparator_generator'

describe Flounder::ComparatorGenerator do

  it 'should be createable' do
    cg = Flounder::ComparatorGenerator.new [1,2,3]
    cg.should_not eq nil
    Object.new.instance_eval cg.generate
  end

  it 'should emit a Comparable compliant comparator method given an array' do
    cg = Flounder::ComparatorGenerator.new ['a','b','c']
    cg.should_not eq nil
    Object.new.instance_eval cg.generate
  end
end