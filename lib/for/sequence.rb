module For
  class Sequence
    # Creates a new Sequence
    def initialize(spec)
      @filter = spec.delete(:where)
      @name, items = spec.first
      @items = items.to_a
      @index = 0
    end

    def each_allowed_by_bindings(bindings)
      @items.each do |item|
        if @filter
          next unless For::Context.build(bindings.merge(@name => item)).instance_eval(&@filter)
        end
        yield @name, item
      end
    end
  end
end
