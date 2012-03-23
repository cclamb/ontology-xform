require_relative 'utilities'

module Flounder

  class ClassGenerator
    include Utilities

    attr_accessor :name, :parent, :mixin, :namespace, :properties, :methods

    def initialize
      self.name = ''
      self.namespace = ''
      self.parent = nil
      self.mixin = nil
      self.methods = []
      yield self if block_given?
    end

    def generate str = '', indent = 0

      indent.times { str << "\t" } ; str << "class #{symbolize name}"

      str << " < #{symbolize parent.name}" if parent

      indent.times { str << "\t" } ; str << "\n"

      mixin_name = mixin.class == ClassGenerator ? mixin.name : mixin.to_s

      if mixin != nil
        indent.times { str << "\t" }
        str << "\tinclude #{mixin_name}\n"
      end

      methods.each do |method|
        method.generate str, indent + 1
      end

      indent.times { str << "\t" } ; str << "end\n"
      str
    end

  end

end