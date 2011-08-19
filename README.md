# For
## Overview
`For` is a Ruby library supporting list comprehensions similar to those found in Clojure and many other languages.
It was started as a whyday 2011 / LinkedIn August 2011 Hackday project.

## Examples
`For` takes one or more sequence specifications and a block and returns
and enumerable For::Comprehension object. When the comprehension is enumerated,
the block is executed once for each combination that can be formed by taking an element
from each sequence:

    For({ :x => (1..3) }, { :y => [:a, :b] }) do
      [x, y]
    end.to_a
    # => [[1, :a], [1, :b], [2, :a], [2, :b], [3, :a], [3, :b]]

Filter conditions may optionally be specified for the sequences:

    For(
      { :x => (1..3), :where => Proc.new { x.odd? } },
      { :y => [:a, :b] }
    ) do
      [x, y]
    end.to_a
    # => [[1, :a], [1, :b], [3, :a], [3, :b]]

Conditions may also optionally be specified to the comprehension as a whole:

    For(
      { :x => (1..4) },
      { :y => (1..4) },
      :where => Proc.new { x < y }
    ) do
      [x, y]
    end.to_a
    # => [[1, 2], [1, 3], [1, 4], [2, 3], [2, 4], [3, 4]]

## Supported Rubies
For has been tested with

- Ruby 1.8.7
- Ruby 1.9.2
- JRuby 1.6.3

## Copyright
Copyright (c) 2011 Greg Spurrier. See LICENSE.txt for further details.
