module Flounder

  class MethodGenerator

    attr_accessor :name, :args, :instructions

    def initialize
      self.name = ''
      self.args = []
      self.instructions = []
      yield self if block_given?
    end

    def generate str = '', indent = 0
      indent.times { str << "\t" } ; str << "def #{name}"
      if args.size > 0
        str << ' '
        for idx in 0..(args.size - 1)
          str << "#{args[idx]}"
          str << ', ' unless idx >= args.size - 1
        end
      end
      str << "\n"
      instructions.each { |i| indent.times { str << "\t" } ; str << "\t#{i}\n" }
      indent.times { str << "\t" }; str << "end\n"
      str
    end

  end

end