# frozen_string_literal: true

require 'bundler'

Bundler.require

require 'active_support/json'
require 'active_support/core_ext/object'

Dry::Types.load_extensions(:maybe)

module Types
  include Dry.Types()
end

class Test < Dry::Struct
  attribute :missing, Types::String.maybe
end

t1 = Test.new(missing: 'Not really') # OK
puts t1_attribute: t1.missing
puts t1_attribute_class: t1.missing.class # Some(String)

t2 = Test.new(missing: nil) # OK
puts t2_attribute: t2.missing
puts t2_attribute_class: t2.missing.class # None

t3 = Test.new # Doesn't fail
puts t3_attribbute: t3.missing # None
puts t3_attribute_class: t3.missing.class # None

# Call to_json
puts t1.to_json # {"missing":{"value":"Not really"}}
puts t2.to_json # {"missing":{}}
puts t3.to_json # "missing":{"trace":"<snip>/ruby/gems/2.7.0/gems/dry-types-1.5.0/lib/dry/types/extensions/maybe.rb:29:in `call_unsafe'"}}
