class SensorReadingsController < ApplicationController
  before_filter :authenticate_user!

  # returns the result of a query 
  # project: <id>, required
  # start_time: if null returns data starting at the first result
  # end_time: if null returns data until the current time
  # sensors: if null returns data for all sensors
  #
  def index

  end

  # parses json parameters to insert readings in the database
  # {project: <id>, required
  #   sensors: [ {
  #             project_index: an integer.  if it doesn't exist a new sensor will be created
  #             readings: [{time: timeStamp, value: integer}]
  #             }
  #          ]
  # }
  #
  #
  #
  def create
    json_params = params['sensorReadings']
    @project = Project.find json_params['project_id']
    sensors = json_params['sensors']
    added_readings = {}
    sensors.each do |sensor_param|
      sensor = @project.find_or_create_sensor sensor_param['project_index']
      added_readings[sensor.project_index] = SensorReading.add_readings sensor.id, sensor_param['readings']
    end
    render status: 200, json: added_readings

  end

  def destroy

  end
end
