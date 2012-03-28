require 'rspec'

require_relative '../../lib/flounder/value_property_generator'

describe Flounder::ValuePropertyGenerator do
  
  it 'should be creatable' do
    vpg = Flounder::ValuePropertyGenerator.new
    vpg.should_not eq nil
  end

  it 'should emit a value property accessor by default' do
    vpg = Flounder::ValuePropertyGenerator.new
    result = vpg.generate
    result.include?('attr_accessor :value').should eq true
  end

end