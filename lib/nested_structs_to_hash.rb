class NestedStructsToHash
  def self.call(hash)
    Transformations[:map_values].call(hash, ->(val) { val.is_a?(Dry::Struct) ? val.to_h : val })
  end
end
