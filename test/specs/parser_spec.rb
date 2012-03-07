require 'rspec'

require_relative '../../lib/flounder/parser'

SIMPLE_ONTOLOGY_FILE_LOCATION = 'etc/simple-ontology.owl'

describe Flounder::Parser do

  it 'should be creatable' do
    builder = Flounder::Parser.new
    builder.should_not eq nil
  end
  
  it 'should return unstructured elements with their attributes' do
    builder = Flounder::Parser.new
    xml = File.read SIMPLE_ONTOLOGY_FILE_LOCATION
    results = builder.parse xml
    elems = results[:elements]
    elems.should_not eq nil
    elems.size.should eq 6
  end

  it 'should return structure information keyed by class name'

end