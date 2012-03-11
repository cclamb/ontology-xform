module Flounder

  class ClassGenerator

    attr_accessor :name, :parent, :mixin

    def initialize
      self.name = ''
      self.parent = nil
      self.mixin = nil
      yield self if block_given?
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