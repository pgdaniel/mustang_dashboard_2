class CanDataController < ApplicationController
  skip_before_action :verify_authenticity_token
  include ActionController::Live

  def receive_message
    data = params[:data]

    # # render nothing: true
    # head :no_content  # This sends an HTTP 204 No Content response

    # data = params[:data]
    # source = SSE.new(response.stream)
    # source.write({ event: 'can_message', data: data }.to_json)
    # puts data
    # Assuming you are using the same Redis connection for ActionCable
    # ActionCable.server.redis.publish('can_messages_channel', data)
    # Or if you prefer to use a list:
    # ActionCable.server.redis.rpush('can_messages_queue', data)

    # process data from dbc file?
    # or have the raw data sent along with data that has been preprocessed

    ActionCable.server.broadcast("dashboard_channel", JSON.dump({ incoming_data: "speed",  data: 100 }))
    ActionCable.server.broadcast("dashboard_channel", JSON.dump({ incoming_data: "rpm",  data: 3500 }))

    ActionCable.server.broadcast("dashboard_channel", JSON.dump({ incoming_data: "wheel_speed_1",  data: 102 }))
    ActionCable.server.broadcast("dashboard_channel", JSON.dump({ incoming_data: "wheel_speed_2",  data: 102 }))
    ActionCable.server.broadcast("dashboard_channel", JSON.dump({ incoming_data: "wheel_speed_3",  data: 102 }))
    ActionCable.server.broadcast("dashboard_channel", JSON.dump({ incoming_data: "wheel_speed_4",  data: 102 }))

    # ActionCable.server.broadcast("dashboard_channel", JSON.dump({ incoming_data: "stuff",  data: data }))
    head :ok
  end
end
