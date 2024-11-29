class CanDataProcessor
  def initialize(data)
    @data = data
    config_file = File.join(Rails.root, 'data', 'data_translate.yml')
    @config = YAML.load_file(config_file)
  end

  def extract_substring(text)
    match = text.match(/\((.*?)\)/)
    match ? match[1] : nil
  end

  def parsed_can_message_title
    parsed_can_message.split("(")[0]
  end

  def extract_items_from_message(items)
    h = items.split(',').map { |i| i.split(": ").each { |i| i.strip! } }
    hashed_items = Hash[h]
  end

  def process
    raw_can_message, parsed_can_message = @data.split("::")
    message_id = raw_can_message.split.first

    case message_id
    when "201"
      process_201(parsed_can_message)
    end
  end


  def process_201(message)
    result = extract_items_from_message(extract_substring(message))

    # Only want these out of the message ID 201
    r = result.select do |key, value|
      key == "VEH_SPD" || key == "ENG_SPD" || key == "ACCEL_PDL_POS"
    end

    vehicle_data = Hash.new
    engine_data = Hash.new

    r.each do |key, value|
      case key
      when "VEH_SPD"
        vehicle_data[:mph] = value.split.first.to_f / 1.609344
      when "ENG_SPD"
        engine_data[:rpm] = value.split.first.to_i
      when "ACCEL_PDL_POS"
        engine_data[:throttle_position_percentage] = value.split.first.to_f
      end
    end

    vehicle_data[:engine] = engine_data
    vehicle_data
  end
end
