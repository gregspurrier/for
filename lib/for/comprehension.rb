module For
  class Comprehension
    include Enumerable

    def initialize(sequence_specs, combiner)
      @sequences = sequence_specs.map { |spec| For::Sequence.new(spec) }
      @combiner = combiner
    end

    def each(&blk)
      each_internal(@sequences, {}, blk)
    end

    def each_internal(sequences, bindings, proc)
      if sequences.empty?
        proc.call(For::Context.build(bindings).instance_eval(&@combiner))
      else
        sequence = sequences.first
        rest = sequences.drop(1)
        sequence.each do |name, value|
          bindings[name] = value
          each_internal(rest, bindings, proc)
        end
      end
    end
  end
end
