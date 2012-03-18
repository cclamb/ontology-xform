module Flounder

  class ClassGenerator

    attr_accessor :name, :parent, :mixin, :namespace

    def initialize
      self.name = ''
      self.namespace = ''
      self.parent = nil
      self.mixin = nil
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
    end

    def generate str = '', indent = 0
      indent.times { str << "\t" } ; str << "class #{symbolize name}"
      str << " < #{symbolize parent.name}" if parent
      indent.times { str << "\t" } ; str << "\n"
      indent.times { str << "\t" } ; str << "\tinclude #{mixin.name}" if mixin
      str << "\n"
      indent.times { str << "\t" } ; str << "end\n"
      str
    end

  end

end