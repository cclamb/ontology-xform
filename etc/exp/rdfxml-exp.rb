require 'rdf'
require 'rdf/rdfxml'

RDF::RDFXML::Reader.open("./Ontology.owl") do |reader|
  reader.each_statement do |statement|
    puts statement.inspect
  end
end