# frozen_string_literal: true

# Base class for all the types
require "randrizer/types/base_type"

# Primitive types. They should not depend on each other.
require "randrizer/types/const"
require "randrizer/types/bool"
require "randrizer/types/int"
require "randrizer/types/float"
require "randrizer/types/string"

# Wrapper types. Once evaluated, they evaluate to a primitive type.
require "randrizer/types/one_of"
require "randrizer/types/skip"
require "randrizer/types/optional"
require "randrizer/types/nullable"

# Iterable types. They might inspect the internal types to special case behaviour and
# as such must be declared after the primitive types.
require "randrizer/types/list"
require "randrizer/types/dict"
require "randrizer/types/string_sequence"
