class Engine
  attr_accessor :rpm, :oil_pressure_psi, :temp_c, :temp_f

  def initialize(rpm:, raw_oil_pressure:, temp_c:)
    @rpm = rpm
    @oil_pressure_psi = (raw_oil_pressure * 14.50377)
    @temp_f = temp_c * (9/5) + 32
    @temp_c = temp_c
  end
end
