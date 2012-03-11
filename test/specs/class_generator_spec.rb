require 'rspec'

require_relative '../../lib/flounder/class_generator'
require_relative '../../lib/flounder/module_generator'

describe Flounder::ClassGenerator do

  it 'should be creatable without a context' do
    c = Flounder::ClassGenerator.new
    c.should_not eq nil
  end

  it 'should be creatable with a context' do
    c = Flounder::ClassGenerator.new do |ctx|
      ctx.name = 'FooBar'
    end
    c.should_not eq nil
  end

  it 'should emit a class with a name' do
    c = Flounder::ClassGenerator.new do |ctx|
      ctx.name = 'FooBar'
    end
    c.should_not eq nil
    rby = ''
    c.generate rby
    rby.include?('class').should eq true
    rby.include?('FooBar').should eq true
    rby.include?('end').should eq true
    Object.new.instance_eval rby
  end

  it 'should emit a class with a name and parent' do
    p = Flounder::ClassGenerator.new { |ctx| ctx.name = 'Parent' }
    c = Flounder::ClassGenerator.new do |ctx|
      ctx.name = 'FooBar'
      ctx.parent = p
    end
    c.should_not eq nil
    rby = ''
    p.generate rby
    c.generate rby
    rby.include?('class').should eq true
    rby.include?('FooBar').should eq true
    rby.include?('end').should eq true
    rby.include?('Parent').should eq true
    Object.new.instance_eval rby
  end

  it 'should handle mixins' do
    mixin = Flounder::ModuleGenerator.new { |ctx| ctx.name = 'Mixin' }
    p = Flounder::ClassGenerator.new { |ctx| ctx.name = 'Parent' }
    c = Flounder::ClassGenerator.new do |ctx|
      ctx.name = 'FooBar'
      ctx.parent = p
      ctx.mixin = mixin
    end
    c.should_not eq nil
    rby = ''
    mixin.generate rby
    p.generate rby
    c.generate rby
    rby.include?('class').should eq true
    rby.include?('FooBar').should eq true
    rby.include?('end').should eq true
    rby.include?('Parent').should eq true
    Object.new.instance_eval rby
  end
end