-- Temperature Widget
-- 2020/03/15 Created

function temperatureInfo ()
  local path = "/sys/class/hwmon/hwmon"
  local fileHandler = nil
  local temperatue = nil
  local result = ''
  local resultAvailable = false
  local coreTempName = 'coretemp'

  for monCounter=0,16,1 do
    nameHandler = io.open (path .. monCounter .. '/name', "r")
    if nameHandler ~= nil then
      name = nameHandler:read()
      nameHandler:close()
      if name == coreTempName then
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
  end
end
