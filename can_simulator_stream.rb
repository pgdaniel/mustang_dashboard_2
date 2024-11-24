require 'net/http'
require 'uri'
require 'json'

class CanSimulator
  def initialize(host, port, path)
    @uri = URI("http://#{host}:#{port}#{path}")
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @request = Net::HTTP::Get.new(@uri)
    @request['Accept'] = 'text/event-stream'
  end

  def simulate
    response = @http.request(@request) do |res|
      res.read_body do |chunk|
        process_chunk(chunk)
      end
    end
  rescue => error
    puts "Error in streaming: #{error.message}"
    retry  # You might want to implement a more sophisticated retry logic
  end

  private

  def process_chunk(chunk)
    # Since we are now initiating the stream, we'll simulate generating CAN messages
    # and writing them to the stream.
    can_message = generate_can_message
    write_message_to_stream(can_message)
    puts "Sent CAN message: #{can_message}"
    sleep(1) # Simulate message frequency
  end

  def generate_can_message
    {
      bus_id: 1,
      id: rand(1..1000),
      timestamp: Time.now.to_i,
      data: Array.new(8) { rand(0..255).to_s(16).rjust(2, '0') }.join(' '),
      dlc: 8
    }
  end

  def write_message_to_stream(message)
    # Writing to the stream actually happens in Rails. Here we're just simulating this:
    puts "Writing message to stream: #{message}"
    # In a real scenario, you'd need a way to write to the stream opened by Rails.
    # This part would be handled by your Rails app, not this script.
  end
end

# Usage
#simulator = CanSimulator.new('localhost', 3000, '/can_data/stream')
#simulator = CanSimulator.new('localhost', 3000, '/can_data/receive_message')
simulator.simulate
