--[[
  Author: Dand
  URL: https://github.com/dandmine/Luana/blob/main/DataSaver.lua

  1. Add this into a file for any modular use
  2. Create an empty Data.lua file in the same directory (this is where the information will be stored)
]]

local DataSaver = {}

function DataSaver:GetValue(k)
   k = tostring(k)
   for line in io.lines("Data.lua") do
      local key,datatype,value = line:match("(.*);(.*);(.*)")
      if key == k then
         if datatype == "string" then
            return value
         elseif datatype == "number" then
            return tonumber(value)
         elseif datatype == "boolean" then
            return value == "true" and true or "false"

         elseif datatype == "nil" then
            return nil
         end
      end
   end
end

function DataSaver:SetValue(k,v)
   local t = type(v)
   if t == "string" or t == "number" or t == "boolean" or t == "nil" then
      k = tostring(k)
      local overwrite = false
      local file = {}
      for line in io.lines("Data.lua") do
         file[#file+1] = line
         local key,datatype,value = line:match("(.*);(.*);(.*)")
         if key == k then
            overwrite = true
            file[#file] = k..";"..t..";"..v
         end
      end
      if not overwrite then
         file[#file+1] = k..";"..t..";"..v
      end
      local f = io.open("Data.lua", "w")
      f:write(table.concat(file, "\n"))
      f:close()
   else
      error("Unsupported datatype!", 2)
   end
end

return DataSaver
