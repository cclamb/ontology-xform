require 'rspec'

require_relative '../../lib/flounder/description_builder'

describe Flounder::DescriptionBuilder do

  it 'should be creatable' do
    builder = Flounder::DescriptionBuilder.new
    builder.should_not eq(nil)
  end
  
  it 'should create a class when a new entity is discovered'
  it 'should create properties when relationships are discovered'

end


