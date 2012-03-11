module Flounder

  class ModuleGenerator

    attr_accessor :name, :elements

    def initialize
      self.name = ''
      self.elements = []
      yield self if block_given?
    end

    def generate str, indent = 0
      indent.times { str << "\t" } ; str << "module #{name}\n"
      elements.each { |e| e.generate str, indent + 1 }
      indent.times { str << "\t" } ; str << "end\n"
    end

  end

end