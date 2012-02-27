require 'nokogiri'

module Flounder
	
	class Ontology < Nokogiri::XML::SAX::Document
		def initialize		
			@element = Hash.new
			@properties = Array.new
			@entities = Array.new
		end

		
		def start_element(name, attributes)
      puts "  ==> Name: #{name}  Attributes: #{attributes}\n"
			case name
				when 'owl:Class'
					@element[:name] = attributes[0][1]
				when 'rdfs:subClassOf'
					@element[:parent] = attributes[0][1]
			end
		end


		def end_element(name)
			if name == 'owl:Class'
				if @element[:parent] == nil
					@entities << @element[:name]
				else
					@properties << @element
					@element = Hash.new
				end
			end			
		end


		def end_document
			@description = "#Listing Entities\n"	
			@entities.each {|e|
				@description = @description + build_entity(e)
			}
			@description = @description + "#Listing Properties\n"
			@properties.each {|p|
				if @entities.include?(p[:parent]) == true
					@description = @description + build_empty_property(p[:name])
				end
			}
			File.open('ontological description.rb', 'w') {|f| f.write(@description) }
		end


		def build_empty_property(name)
			prop_string = "class #{name.capitalize} < ComparableProperty\n\tdef initialize (value)\n\t\t@value = value\n\tend\nend\n\n"
			return prop_string
		end

		def build_entity(name)
			e_string = "class #{name.capitalize} < Entity\n\tdef initialize(property_list)\n\t\t@properties = property_list\n\tend\nend\n\n"
			return e_string
		end
	end


	class DescriptionBuilder
		def initialize(ont)
			@loc = ont
			@par = Nokogiri::XML::SAX::Parser.new(Ontology.new)
		end

		def generate_description
			@par.parse_file(@loc)
		end
	end

end



#test code
#test = Flounder::DescriptionBuilder.new('../../etc/Ontology.owl')
#test = Flounder::DescriptionBuilder.new('../../etc/Ontology2.owl')
test = Flounder::DescriptionBuilder.new('../../etc/simple-ontology.owl')
test.generate_description