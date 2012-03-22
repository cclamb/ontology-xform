require 'rspec'

require_relative '../../lib/flounder/parser'
require_relative '../../lib/flounder/rectifier'

simple_test = {
  :filename => 'etc/simple-ontology.owl'
}

complex_test = {
  :filename => 'etc/Ontology.owl'
}

complex_test_2 = {
  :filename => 'etc/Ontology2.owl'
}


def merge filename
  parser = Flounder::Parser.new
  xml = File.read filename
  results = parser.parse xml
  rectifier = Flounder::Rectifier.new
  rectifier.rectify results[:elements], results[:structure]
end

describe Flounder::Rectifier do

  it 'should be creatable' do
    rectifier = Flounder::Rectifier.new
    rectifier.should_not eq nil
  end

  context 'with a simple ontology' do

    it 'should be able to merge the structures and elements' do
      od = merge simple_test[:filename]
      Object.new.instance_eval od
    end

    it 'should be able to import new namespaced instances for creation' do
      od = merge simple_test[:filename]
      eval od
      project = Project.new
      project.should_not eq nil
      car = Http___www_semanticweb_org_ontologies_2012_1_Ontology1329225154941_owl::Car.new
      car.should_not eq nil
      car.class.superclass.should eq \
       Http___www_semanticweb_org_ontologies_2012_1_Ontology1329225154941_owl::Machine
    end

  end

  context 'with a complex Ontology (Ontology.owl)' do

    it 'should be able to merge the structures and elements' do
      od = merge complex_test[:filename]
      od.should_not eq nil
      Object.new.instance_eval od
    end

    it 'should be able to import new namespaced instances for creation' do
      od = merge complex_test[:filename]
      eval od
      jwics = Http___www_semanticweb_org_ontologies_2012_1_Ontology_owl::JWICS.new
      jwics.should_not eq nil
      nasnet = Http___www_semanticweb_org_ontologies_2012_1_Ontology_owl::NASNet.new
      nasnet.should_not eq nil
    end

    it 'should be able to import comparable instances' do
      od = merge complex_test[:filename]
      eval od
      jwics = Http___www_semanticweb_org_ontologies_2012_1_Ontology_owl::JWICS.new
      nasnet = Http___www_semanticweb_org_ontologies_2012_1_Ontology_owl::NASNet.new
      (jwics < nasnet).should eq true
      (jwics > nasnet).should eq false
      unclassified = Http___www_semanticweb_org_ontologies_2012_1_Ontology_owl::Unclassified.new
      secret = Http___www_semanticweb_org_ontologies_2012_1_Ontology_owl::Secret.new
      (secret < unclassified).should eq false
      (secret > unclassified).should eq true
    end

  end

  context 'with a complex Ontology (Ontology2.owl)' do

    it 'should be able to merge the structures and elements' do
      od = merge complex_test_2[:filename]
      od.should_not eq nil
      Object.new.instance_eval od
    end

    it 'should be able to import new namespaced instances for creation'
    it 'should be able to import comparable instances'

  end

end