require_relative 'utilities'

module Flounder

  class ModuleGenerator
      include Utilities
      
    attr_accessor :name, :elements

    def initialize
      self.name = ''
      self.elements = []
      yield self if block_given?
    end

    def generate str = '', indent = 0
      indent.times { str << "\t" } ; str << "module #{symbolize name}\n"
      elements.each { |e| e.generate str, indent + 1 }
      indent.times { str << "\t" } ; str << "end\n"
      str
    end

    def arrange_elements

    end

  end

end