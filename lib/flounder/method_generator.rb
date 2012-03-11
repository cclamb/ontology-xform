module Flounder

  class MethodGenerator

    attr_accessor :name, :instructions

    def initialize
      self.name = ''
      self.instructions = []
      yield self if block_given?
    end

    def generate str, indent = 0
      indent.times { str << "\t" } ; str << "def #{name}\n"
      instructions.each { |i| indent.times { str << "\t" } ; str << "\t#{i}\n" }
      indent.times { str << "\t" }; str << "end\n"
    end

  end

end