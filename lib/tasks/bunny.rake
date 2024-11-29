require 'bunny'

namespace :bunny do
  desc "TODO"
  task send: :environment do
    # Connect to RabbitMQ server
    connection = Bunny.new(host: '192.168.50.84', vhost: '/', user: "paul", password: "blahblah1")  # Change 'localhost' to your RabbitMQ server address if it's not running locally
    connection.start

    # Create a channel
    channel = connection.create_channel

    # Declare an exchange (direct in this case, but you could use fanout, topic, etc.)
    exchange = channel.direct('fast_exchange', :durable => false)

    # Declare a queue
    queue = channel.queue('fast_queue', :durable => false)

    # Bind the queue to the exchange with a routing key
    queue.bind(exchange, :routing_key => 'test_key')

    # The message we want to send
    # message = "Hello, RabbitMQ!"

    message = data = { speed: 777, rpm: 777, oil_pressure: 7777, gear: 7, temp: 7777 }.to_json

    # Publish the message to the exchange with the routing key
    exchange.publish(message, :routing_key => 'test_key')

    puts " [x] Sent '#{message}'"

    # Close the channel and connection
    channel.close
    connection.close
  end
end
