module Flounder

  class ClassGenerator

    attr_accessor :parent, :mixin

    def initialize
      self.name = ''
      self.parent = nil
      self.mixin = nil
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
      indent.times { str << "\t" } ; str << "class #{name}"
      str << " < #{parent.name}" if parent
      indent.times { str << "\t" } ; str << "\n"
      indent.times { str << "\t" } ; str << "\tinclude #{mixin.name}" if mixin
      str << "\n"
      indent.times { str << "\t" } ; str << "end\n"
    end

  end

end