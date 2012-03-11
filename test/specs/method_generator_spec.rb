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
  end
  
end