require 'rspec'

require_relative '../../lib/flounder/equality_generator'

def test_generator values, name = nil
    eg = nil
    if name != nil
      eg = Flounder::EqualityGenerator.new { |c| c.equality_method = name }
    else
      eg = Flounder::EqualityGenerator.new
    end
    str = eg.generate
    ['==', 'eql?', 'hash', 'name'].each { |str| str.include?(str).should eq true }
    Object.new.instance_eval str
end

describe Flounder::EqualityGenerator do

  it 'should be creatable' do
    eg = Flounder::EqualityGenerator.new
    eg.should_not eq nil
  end

  it 'should generate a default equality method' do
    test_generator ['==', 'eql?', 'hash', 'value']
  end

  it 'should accept a submitted equality method' do
    test_generator ['==', 'eql?', 'hash', 'name'], 'name'
  end

end