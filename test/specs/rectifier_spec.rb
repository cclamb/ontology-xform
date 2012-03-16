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

module RectifierSpec

  def RectifierSpec.merge filename
    parser = Flounder::Parser.new
    xml = File.read filename
    results = parser.parse xml
    rectifier = Flounder::Rectifier.new
    rectifier.rectify results[:elements], results[:structure]
  end

  class SimpleTester
    def test
      s = SomeMod::Subject.new
      s.should_not eq nil
    end
  end

end

describe Flounder::Rectifier do

  it 'should be creatable' do
    rectifier = Flounder::Rectifier.new
    rectifier.should_not eq nil
  end

  context 'with a simple ontology' do

    it 'should be able to merge the structures and elements' do
      od = RectifierSpec::merge simple_test[:filename]
      test_ctx = RectifierSpec::SimpleTester.new
      test_ctx.instance_eval od
      test_ctx.instance_exec { test }
    end

  end

  context 'with a complex Ontology (Ontology.owl)' do

    it 'should be able to merge the structures and elements' do
      od = RectifierSpec::merge complex_test[:filename]
      Object.new.instance_eval od
    end

  end

  context 'with a complex Ontology (Ontology2.owl)' do

    it 'should be able to merge the structures and elements' do
      od = RectifierSpec::merge complex_test_2[:filename]
      Object.new.instance_eval od
    end

  end

end