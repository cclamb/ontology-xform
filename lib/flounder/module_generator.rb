module Flounder

  class ModuleGenerator

    attr_accessor :elements

    def initialize
      self.name = ''
      self.elements = []
      yield self if block_given?
    end

    def name=(name)
      unless name == nil or name == ''
        first = name.slice(0).capitalize
        rest = name.slice 1, name.size
        @name = first + rest
      else
        @name = name
      end
    end

    def name
      @name
    end

    def generate str, indent = 0
      indent.times { str << "\t" } ; str << "module #{name}\n"
      elements.each { |e| e.generate str, indent + 1 }
      indent.times { str << "\t" } ; str << "end\n"
    end

    def arrange_elements

    end

  end

end