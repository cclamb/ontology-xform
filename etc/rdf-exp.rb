require 'rdf'
require 'rdf/rdfxml'

# RDF::RDFXML::Reader.open("./Ontology2.owl") do |reader|
#   reader.each_statement do |statement|
#     puts statement.inspect
#   end
# end

filename = 'Ontology2.owl'
# filename = 'Ontology4.owl'
# filename = 'simple-ontology.owl'

# xml = File.read filename

#g = RDF::Graph.load 'file:///home/cclamb/Work/ontology-xform/etc/Ontology2.owl'
g = RDF::Graph.load("http://rdf.rubyforge.org/doap.nt")
# q = RDF::Query.new ({
#   :class => {
#     :about => 'http://www.semanticweb.org/ontologies/2012/1/Ontology.owl#Context'
#   }
# })

g.each do |e|
  puts e.inspect
end

# q.execute(g).each do |solution|
#   puts solution.inspect
# end