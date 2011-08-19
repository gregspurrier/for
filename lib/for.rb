require 'for/comprehension'
require 'for/context'
require 'for/sequence'

def For(*sequence_specs, &blk)
  For::Comprehension.new(sequence_specs, blk)
end
