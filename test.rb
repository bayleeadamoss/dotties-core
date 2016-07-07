class Foo
  attr_accessor :one, :two
  def initialize
    self.one = 10
    @two = 20
  end
end

well = Foo.new

p well.one
p well.two
