require 'net/http'
require 'uri'
require 'json'

class CanSimulator
  def initialize(host, port, path)
    @uri = URI("http://#{host}:#{port}#{path}")
  end

  def simulate
    loop do
      can_message = generate_can_message
      # Send the message to the Rails application
      send_message(can_message)
      puts "Sent CAN message: #{can_message}"
      sleep(1) # Simulate message frequency
    end
  end

  private

  def generate_can_message
    {
      bus_id: 1,
      id: rand(1..1000),
      timestamp: Time.now.to_i,
      data: Array.new(8) { rand(0..255).to_s(16).rjust(2, '0') }.join(' '),
      dlc: 8
    }
  end

  def send_message(message)
    Net::HTTP.post_form(@uri, 'data' => message.to_json)
  rescue => error
    puts "Error sending message: #{error.message}"
    sleep(5) # Wait a bit before retrying or exit script
  end
end

# Usage
simulator = CanSimulator.new('localhost', 3000, '/can_data/receive_message')
simulator.simulate
