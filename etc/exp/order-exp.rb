class Bar < Foo
  def bar
    puts 'bar'
  end
end

class Foo
  def bar
    puts 'foo'
  end
end

b = Bar.new
b.bar