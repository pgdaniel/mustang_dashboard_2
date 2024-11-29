class MessageProcessor
  attr_reader :config, :data

  def initialize(data)
    @data = data
    # @data = data["can_datum"]
    # @config = data["can_datum"]["config"]
  end

  def process
    # hash_data = data.to_unsafe_h
    # symbolized_hash = hash_data.symbolize_keys

    #IRacingProcessor.new(symbolized_hash).process
    IRacingProcessor.new(data).process
  end
end
