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

        sub_elements = c.xpath 'rdfs:subClassOf'
        if sub_elements.size > 0
          name = full_type_name
          parent = sub_elements[0].attribute('resource').to_s
          @structure[name] = parent
        end

        restrictions = c.xpath 'owl:equivalentClass/owl:Restriction'
        clazz_properties = []
        restrictions.each do |r|
          properties = r.xpath 'owl:onProperty'
          objects = r.xpath 'owl:someValuesFrom'
          property = get_short_name properties[0].attribute('resource').value
          object = get_short_name objects[0].attribute('resource').value
          clazz_properties.push :property => property, :object => object
        end
        attribs[:properties] = clazz_properties

        @elements[full_type_name] = attribs
      end

    end

    def get_short_name str
      parts = str.split '#'
      parts.last
    end
    
  end

end