require 'rspec'

require_relative '../../lib/flounder/module_generator'

class TestGenerator
  def generate str, indent = 0
    str << "def foo blech\n"
    str << "\tputs blech\n"
    str << "end\n"
  end
end


describe Flounder::ModuleGenerator do

  it 'should be creatable without a context' do
    m = Flounder::ModuleGenerator.new
    m.should_not eq nil
  end

  it 'should be creatable with a context' do
    m = Flounder::ModuleGenerator.new do |ctx|
      ctx.name = 'SomeName'
    end
    m.should_not eq nil
  end

  it 'should be creatable with elements' do
    m = Flounder::ModuleGenerator.new do |ctx|
      ctx.name = 'SomeName'
      ctx.elements = []
    end
    m.should_not eq nil
  end

  it 'should create an empty module with a name' do
    m = Flounder::ModuleGenerator.new do |ctx|
      ctx.name = 'SomeName'
    end
    m.should_not eq nil
    str = ''
    m.generate str
    str.include?('module').should eq true
    str.include?('SomeName').should eq true
    str.include?('end').should eq true
    eval str
  end

  it 'should create a module with content' do
    m = Flounder::ModuleGenerator.new do |ctx|
      ctx.name = 'SomeName'
      ctx.elements = [TestGenerator.new]
    end
    m.should_not eq nil
    str = ''
    m.generate str
    str.include?('module').should eq true
    str.include?('SomeName').should eq true
    str.include?('end').should eq true
    str.include?('foo blech').should eq true
    str.include?('puts blech').should eq true
    eval str
  end

  it 'should create a module in  module' do

    im = Flounder::ModuleGenerator.new do |ctx|
      ctx.name = 'InnerModule'
      ctx.elements = [TestGenerator.new]
    end
    m = Flounder::ModuleGenerator.new do |ctx|
      ctx.name = 'SomeName'
      ctx.elements = [im]
    end
    m.should_not eq nil
    str = ''
    m.generate str
    str.include?('module').should eq true
    str.include?('SomeName').should eq true
    str.include?('end').should eq true
    str.include?('foo blech').should eq true
    str.include?('puts blech').should eq true
    str.include?('InnerModule').should eq true
    eval str
  end
  
end