
module Flounder
  class ValuePropertyGenerator

    def initialize

    end

    def generate str, indent = 0
        @instructions.each { |i| indent.times { str << "\t" } ; str << "\t#{i}\n" }
        str
    end
  end
end
