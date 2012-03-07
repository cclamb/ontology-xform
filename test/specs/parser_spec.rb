require 'rspec'

require_relative '../../lib/flounder/parser'

describe Flounder::Parser do

  it 'should be creatable' do
    builder = Flounder::Parser.new Object.new
    builder.should_not eq(nil)
  end
  
  it 'should create a class when a new entity is discovered'
  it 'should create properties when relationships are discovered'

end