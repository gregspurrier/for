module For
  class Sequence
    # Creates a new Sequence
    def initialize(spec)
      @name, items = spec.first
      @items = items.to_a
      @index = 0
    end

    def each
      @items.each { |item| yield @name, item}
    end
  end
end
