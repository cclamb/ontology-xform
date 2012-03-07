require 'nokogiri'

module Flounder

  class Parser

    def initialize
      @elements = {}
    end

    def parse xml
      @doc = Nokogiri::XML xml
      parse_classes
      return {:elements => @elements}
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
      end
    end

  end

end