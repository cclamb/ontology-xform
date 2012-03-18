require 'rspec'

require_relative '../../lib/flounder/method_generator'

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
    str = m.generate
    str.include?('def').should eq true
    str.include?('some_method').should eq true
    str.include?('end').should eq true
    Object.new.instance_eval str
  end

  it 'should be creatable with an argument list' do
    m = Flounder::MethodGenerator.new do |ctx|
      ctx.name = 'some_method'
      ctx.args = ['obj']
    end
    str = m.generate
    str.include?('def').should eq true
    str.include?('some_method obj').should eq true
    str.include?('end').should eq true
    Object.new.instance_eval str
  end

  it 'should be creatable with an arbitrary argument list' do
    m = Flounder::MethodGenerator.new do |ctx|
      ctx.name = 'some_method'
      ctx.args = ['obj', 'obj2', 'obj3', 'obj4']
    end
    str = m.generate
    str.include?('def').should eq true
    str.include?('some_method obj, obj2, obj3, obj4').should eq true
    str.include?('end').should eq true
    Object.new.instance_eval str
  end

  it 'should handle operation definitions' do
    m = Flounder::MethodGenerator.new do |ctx|
      ctx.name = '<=>'
      ctx.args = ['obj']
    end
    str = m.generate
    str.include?('def').should eq true
    str.include?('<=> obj').should eq true
    str.include?('end').should eq true
    Object.new.instance_eval str
  end

  it 'should allow for instruction inclusion' do
    m = Flounder::MethodGenerator.new do |ctx|
      ctx.name = '<=>(obj)'
    end

  end

  it 'should accept a variety of templated instructions'
  
end