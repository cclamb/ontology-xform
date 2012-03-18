require 'rspec'

require_relative '../../lib/flounder/method_generator'

def test_method_generator g, args
  str = g.generate
  str.include?('def').should eq true
  test_heading = args[:name]
  unless args[:args] == nil
    test_heading << ' '
    for idx in 0..(args[:args].size - 1)
      test_heading << "#{args[:args][idx]}"
      test_heading << ', ' unless idx >= args[:args].size - 1
    end
  end
  str.include?(test_heading).should eq true
  str.include?('end').should eq true
  Object.new.instance_eval str
end

describe Flounder::MethodGenerator do

  it 'should be creatable without a context' do
    m = Flounder::MethodGenerator.new
    m.should_not eq nil
  end

  it 'should be creatable with a context' do
    m = Flounder::MethodGenerator.new do |ctx|
      ctx.name = 'some_method'
    end
    m.should_not eq nil
    test_method_generator m, :name => 'some_method'
  end

  it 'should be creatable with an argument list' do
    m = Flounder::MethodGenerator.new do |ctx|
      ctx.name = 'some_method'
      ctx.args = ['obj']
    end
    test_method_generator m, :name => 'some_method', :args => ['obj']
  end

  it 'should be creatable with an arbitrary argument list' do
    args = ['obj', 'obj2', 'obj3', 'obj4']
    m = Flounder::MethodGenerator.new do |ctx|
      ctx.name = 'some_method'
      ctx.args = args
    end
    test_method_generator m, :name => 'some_method', :args => args
  end

  it 'should handle operation definitions' do
    m = Flounder::MethodGenerator.new do |ctx|
      ctx.name = '<=>'
      ctx.args = ['obj']
    end
    test_method_generator m, :name => '<=>', :args => ['obj']
  end

  it 'should allow for instruction inclusion'
  it 'should accept a variety of templated instructions'
  
end