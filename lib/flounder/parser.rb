require 'nokogiri'

module Flounder

  class Parser

    def initialize
      @elements = {}
      @structure = {}
    end

    def parse xml
      @doc = Nokogiri::XML xml
      parse_classes
      return {:elements => @elements, :structure => @structure}
    end

    private

    def parse_classes
      clz = @doc.xpath '//owl:Class'
      clz.each do |c|
        attribs = {}
        c.attributes.each do |key, value|
          attribs[key.to_sym] = value.to_s
        end

        full_type_name = attribs[:about]
        @elements[full_type_name.to_sym] = attribs

        sub_elements = c.xpath 'rdfs:subClassOf'
        if sub_elements.size > 0
          name = full_type_name.to_sym
          parent = sub_elements[0].attribute('resource').to_s.to_sym
          @structure[name] = parent
        end
      end
    end
    
  end

end