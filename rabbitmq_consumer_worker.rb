require 'bunny'
require 'pry'

class RabbitmqConsumerWorker
  # include Sidekiq::Worker

  def perform
    start_consuming
  end

  private

  def start_consuming
    connection = Bunny.new
    connection.start

    channel = connection.create_channel
    queue = channel.queue('example_queue', durable: true)

    queue.subscribe(block: true) do |delivery_info, properties, payload|
      # Process each message
      process_message(payload)

      # If you need to acknowledge the message:
      # channel.acknowledge(delivery_info.delivery_tag, false)
    end
  rescue Bunny::TCPConnectionFailed => e
    Rails.logger.error "Connection failed: #{e.message}"
    # Consider implementing a retry mechanism here
  ensure
    # Ensure block to handle graceful shutdown
    # This will not be executed if the worker is killed with SIGKILL
    connection.close if connection && !connection.closed?
  end

  def process_message(payload)
    # Your logic to process the message
    binding.pry
  end
end

RabbitmqConsumerWorker.new.perform
