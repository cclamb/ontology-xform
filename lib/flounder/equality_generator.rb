require_relative 'method_generator'

module Flounder

  class EqualityGenerator

    attr_accessor :equality_method

    def initialize
      self.equality_method = 'value'
      yield self if block_given?
      @instructions = []
      @instructions.push "def == obj"
      @instructions.push "\tself.class == obj.class && self.#{equality_method} == obj.#{equality_method}"
      @instructions.push "end"
      @instructions.push "def eql? obj"
      @instructions.push "\tself == obj"
      @instructions.push "end"
      @instructions.push "def hash"
      @instructions.push "\tself.name.hash"
      @instructions.push "end"
    end

    def generate str = '', indent = 0
      @instructions.each { |i| indent.times { str << "\t" } ; str << "\t#{i}\n" }
      str
    end

  end

end