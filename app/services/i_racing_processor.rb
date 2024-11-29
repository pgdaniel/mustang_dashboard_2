require "ostruct"

class IRacingProcessor
  attr_accessor :vehicle

  def initialize(data)
    @i_racing_data = OpenStruct.new(
      speed: data[:speed],
      gear: data[:gear],
      rpm: data[:rpm],
      temp: data[:temp],
      oil_pressure: data[:oil_pressure]
    )

    @vehicle = Vehicle.new(@i_racing_data)
  end

  def process
    ActionCable.server.broadcast("dashboard_channel", vehicle.to_json)
  end
end
