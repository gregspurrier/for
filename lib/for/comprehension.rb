module For
  class Comprehension
    include Enumerable

    def initialize(sequence_specs, combiner)
      specs = sequence_specs.dup
      if specs.last.keys == [:where]
        @filter = specs.pop[:where]
      end
      @sequences = specs.map { |spec| For::Sequence.new(spec) }
      @combiner = combiner
    end

    def each(&blk)
      each_internal(@sequences, {}, blk)
    end

    def each_internal(sequences, bindings, proc)
      if sequences.empty?
        context = For::Context.build(bindings)
        unless @filter && !context.instance_eval(&@filter)
          proc.call(context.instance_eval(&@combiner))
        end
      else
        sequence = sequences.first
        rest = sequences.drop(1)
        sequence.each_allowed_by_bindings(bindings) do |name, value|
          each_internal(rest, bindings.merge(name => value), proc)
        end
      end
    end
  end
end
