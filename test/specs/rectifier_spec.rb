require 'rspec'

require_relative '../../lib/flounder/parser'
require_relative '../../lib/flounder/rectifier'

simple_test = {
  :filename => 'etc/simple-ontology.owl',
}

complex_test = {
  :filename => 'etc/Ontology.owl',
}

complex_test_2 = {
  :filename => 'etc/Ontology2.owl',
}

def merge filename
  parser = Flounder::Parser.new
  xml = File.read filename
  results = parser.parse xml
  rectifier = Flounder::Rectifier.new
  rectified_results = rectifier.rectify results[:elements], results[:structure]
  #puts "Results: #{rectified_results}"
  fail 'unimplemented'
end

describe Flounder::Rectifier do

  it 'should be creatable' do
    rectifier = Flounder::Rectifier.new
    rectifier.should_not eq nil
  end

  context 'with a simple ontology' do

    it 'should be able to merge the structures and elements' do
      merge simple_test[:filename]
    end

  end

  context 'with a complex Ontology (Ontology.owl)' do

    it 'should be able to merge the structures and elements' do
      merge complex_test[:filename]
    end

  end

  context 'with a complex Ontology (Ontology2.owl)' do

    it 'should be able to merge the structures and elements' do
      merge complex_test_2[:filename]
    end

  end

end