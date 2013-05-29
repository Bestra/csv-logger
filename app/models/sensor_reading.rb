class SensorReading
  include Mongoid::Document

  belongs_to :sensor
  field :time, type: DateTime
  field :value

  def self.add_readings(sensor_id, readings)
    readings.reduce 0 do |added_count, reading|
      r = SensorReading.new sensor_id: sensor_id, time: Time.parse(reading['time']), value: reading['value'].to_i
      if r.save
        added_count + 1
      end
    end
  end

  def self.query_sensor(project, sensor_index, start_time, end_time, result_limit)

  end

  def self.query_sensor_readings(sensor_query)

  end
end
