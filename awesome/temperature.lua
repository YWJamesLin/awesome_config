-- Temperature Widget
-- 2020/03/15 Created

function temperatureInfo ()
  local path = "/sys/class/hwmon/hwmon"
  local fileHandler = nil
  local temperatue = nil
  local result = ''
  local resultAvailable = false

  for monCounter=0,16,1 do
    for counter=1,16,1 do
      fileHandler = io.open (path .. monCounter .. '/temp' .. counter .. '_input', "r")
      if fileHandler ~= nil then
        temperature = fileHandler:read() / 1000 .. '°C'
        fileHandler:close()
        if result == '' then
          result = result .. temperature
        else
          result = result .. ' ' .. temperature
        end

        resultAvailable = true
      end
    end
    if resultAvailable then
      result = result .. ' '
      return result
    end
  end
end
