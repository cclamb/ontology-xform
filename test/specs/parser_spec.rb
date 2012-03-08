require 'rspec'

require_relative '../../lib/flounder/parser'

Simple_Test = {
  :filename => 'etc/simple-ontology.owl',
  :element_size => 6,
  :structure_size => 4
}

Complex_Test = {
  :filename => 'etc/Ontology.owl',
  :element_size => 17,
  :structure_size => 15 
}

Complex_Test_2 = {
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

  context 'Simple Ontology (simple-ontology.owl)' do
      
    it 'should return unstructured elements with their attributes' do
      elements_test Simple_Test[:filename], Simple_Test[:element_size]
    end

    it 'should return structure information keyed by class name' do
      structure_test Simple_Test[:filename], Simple_Test[:structure_size]
    end

  end

  context 'Complex Ontology (Ontology.owl)' do

    it 'should return unstructured elements with their attributes' do
      elements_test Complex_Test[:filename], Complex_Test[:element_size]
    end

    it 'should return structure information keyed by class name' do
      structure_test Complex_Test[:filename], Complex_Test[:structure_size]
    end

  end

  context 'Complex Ontology (Ontology2.owl)' do

    it 'should return unstructured elements with their attributes' do
      elements_test Complex_Test_2[:filename], Complex_Test_2[:element_size]
    end

    it 'should return structure information keyed by class name' do
      structure_test Complex_Test_2[:filename], Complex_Test_2[:structure_size]
    end

  end

end