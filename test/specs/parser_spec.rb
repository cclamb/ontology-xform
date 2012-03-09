require 'rspec'

require_relative '../../lib/flounder/parser'

simple_test = {
  :filename => 'etc/simple-ontology.owl',
  :element_size => 6,
  :structure_size => 4
}

complex_test = {
  :filename => 'etc/Ontology.owl',
  :element_size => 17,
  :structure_size => 15 
}

complex_test_2 = {
  :filename => 'etc/Ontology2.owl',
  :element_size => 17,
  :structure_size => 15 
}

def elements_test(filename, size)
  builder = Flounder::Parser.new
  xml = File.read filename
  results = builder.parse xml
  elems = results[:elements]
  elems.should_not eq nil
  elems.size.should eq size
end

def structure_test(filename, size)
  builder = Flounder::Parser.new
  xml = File.read filename
  results = builder.parse xml
  structure = results[:structure]
  structure.should_not eq nil
  structure.size.should eq size
end

describe Flounder::Parser do

  it 'should be creatable' do
    builder = Flounder::Parser.new
    builder.should_not eq nil
  end

  context 'with a Simple Ontology (simple-ontology.owl)' do
      
    it 'should return unstructured elements with their attributes' do
      elements_test simple_test[:filename], simple_test[:element_size]
    end

    it 'should return structure information keyed by class name' do
      structure_test simple_test[:filename], simple_test[:structure_size]
    end

  end

  context 'with a complex Ontology (Ontology.owl)' do

    it 'should return unstructured elements with their attributes' do
      elements_test complex_test[:filename], complex_test[:element_size]
    end

    it 'should return structure information keyed by class name' do
      structure_test complex_test[:filename], complex_test[:structure_size]
    end

  end

  context 'with a complex Ontology (Ontology2.owl)' do

    it 'should return unstructured elements with their attributes' do
      elements_test complex_test_2[:filename], complex_test_2[:element_size]
    end

    it 'should return structure information keyed by class name' do
      structure_test complex_test_2[:filename], complex_test_2[:structure_size]
    end

  end

end