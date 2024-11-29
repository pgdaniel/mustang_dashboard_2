class Vehicle
  attr_accessor :raw_speed, :mph, :kph, :gear, :engine

  def initialize(data)
    @raw_speed = data.speed
    @mph = (@raw_speed * 2.23694)
    @kph = (@raw_speed * 3.6)
    @gear = data.gear

    @engine = Engine.new(
      rpm: data.rpm,
      raw_oil_pressure: data.oil_pressure,
      temp_c: data.temp
    )
  end

  def mph
    meters_per_second_to_mph
  end

  def meters_per_second_to_mph
    raw_speed * 2.23694
  end

  def meters_per_second_to_kph
    999
  end
end
