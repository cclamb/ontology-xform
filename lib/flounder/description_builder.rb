require 'nokogiri'
include Nokogiri

module Flounder
	
	class Ontology < XML::SAX::Document
		def initialize		
			@elements = Array.new
			@description
		end
		
		def start_element(element, attributes)
			if element == 'owl:Class'
				attributes.each { |att|
					if att[0] == 'ref:about'
						@elements << att[1]
					end
				}
			end
		end

		def end_document

			@elements.each {|e|
				@description = String.new
				@description = @description + self.build_class(e)
			}
		
			puts @description
		end

		def build_class(name)
			class_string = "class #{name.capitalize}\n\tdef initialize\n\tend\nend\n\n"
			return class_string
		end
	end


	class DescriptionBuilder
		def initialize(ont)
			@loc = ont
			@par = XML::SAX::Parser.new(Ontology.new)
		end

		def generate_description
			@par.parse_file(@loc)
		end
	end

end



#test code
test = Flounder::DescriptionBuilder.new('../../etc/simple-ontology.owl')
test.generate_description
