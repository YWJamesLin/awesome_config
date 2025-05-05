-- Battery Widget -- capacity, available time, power
-- 2015/10/02 Created

local showCapacity = true
local showAvailable = true
local showPower = true

function readFirstFile (adapter, ...)
  local basepath = "/sys/class/power_supply/"..adapter.."/"
  for i, name in pairs ({...}) do
    file = io.open (basepath..name, "r")
    if file then
      local str = file:read ()
      file:close ()
      return str
    end
  end
end

function batteryInfo (adapter)
  local fh = io.open ("/sys/class/power_supply/" .. adapter .. "/present", "r")
  if fh == nil then
    return ""
  else
    local sta = readFirstFile (adapter, "status")
    if sta:match ("Full") or sta:match ("Unknown") then
      if showCapacity then
        return " " .. sta .. " "
      else
        return ""
      end
    else
      local retString = " "
      if showCapacity then
        local battery = tonumber (readFirstFile (adapter, "capacity"))
        if not battery then
          local cha = readFirstFile (adapter, "charge_now", "energy_now")
          local cha_full = readFirstFile (adapter, "charge_full", "energy_full")
          battery = math.floor (100. * cha / cha_full)
        end
        if sta:match ("Charging") then
          retString = retString .. "⚡" .. battery .. "% "
        elseif sta:match ("Discharging") then
          retString = retString .. "　" .. battery .. "% "
        end
      end

      if showAvailable or showPower then
        -- common variables to calculate available time and watt
        --
        local power = readFirstFile (adapter, "power_now") / 1000
        --local voltage = readFirstFile (adapter, "voltage_now") / 1000

        if showAvailable then
          local fill
          if sta:match ("Charging") then
            fill = readFirstFile (adapter, "energy_full") - readFirstFile (adapter, "energy_now");
          elseif sta:match ("Discharging") then
            fill = readFirstFile (adapter, "energy_now")
          end
          local seconds = 36. * fill / 10 / power
          local hr = math.floor (seconds / 3600)
          local min = math.floor (seconds % 3600 / 60)
          local zero
          if min < 10 then 
            zero = "0"
          else
            zero = ""
          end
          retString = retString .. "[ " .. hr .. ":" .. zero .. min .. " ] "
        end

        if showPower then
          local power = power / 1000
          retString = retString .. power  .. "W "
        end
      end

      return retString
    end
  end
end
