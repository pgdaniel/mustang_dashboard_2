#  require './lib/engine_status_pb'

class CanDataController < ApplicationController
  skip_before_action :verify_authenticity_token

  def receive_message
    # data = params[:data]
    # data = request.body.read

    # deserialized_data = EngineData::EngineStatus.decode(data)

    # puts deserialized_data.rpm
    # puts deserialized_data.temp
    # puts deserialized_data.oil_pressure

    # data = params[:data]

    can_data = params[:can_datum][:data][1]

    processed_can_data = CanDataProcessor.new(can_data).process
    ActionCable.server.broadcast("dashboard_channel", processed_can_data.to_json)

    head :ok
  end
end
