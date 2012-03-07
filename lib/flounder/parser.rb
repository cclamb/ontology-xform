require 'nokogiri'

module Flounder

  class Parser

    def initialize event_adapter
      @event_adapter = event_adapter
      @elements = {}
    end

    def parse xml
      @doc = Nokogiri::XML xml
      parse_classes
      return {:elements => @elements}
    end

    private

    def parse_classes
      clz = @doc.path '//owl:Class'
      attribs = {}
      clz.attributes.each do |key, value|
        attribs.put[key] = vale
      end
      clz.each do |c|
        @elements.put[c.name] = attribs
      end
    end

  end

end