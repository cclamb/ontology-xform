module Flounder

  class ModuleGenerator

    attr_accessor :name, :elements

    def initialize
      self.name = ''
      self.elements = []
      yield self if block_given?
    end

    def symbolize name
      unless name == nil or name == ''
        first = name.slice(0).capitalize
        rest = name.slice 1, name.size
        @name = first + rest
      else
        @name = name
      end
      unless @name == nil
        puts @name
        new_name = @name.gsub! /#|\/|:|\./, '_'
        puts new_name
        @name == new_name unless new_name == nil || new_name == ''
        puts @name
      end
      @name
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