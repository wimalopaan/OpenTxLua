--
-- WM OTXE - OpenTX Extensions 
-- Copyright (C) 2020 Wilhelm Meier <wilhelm.wm.meier@googlemail.com>
--

-- This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
-- To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ 
-- or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

--local valuestrings = { "Normal", "Monitor Bug", "Monitor Heck", "Scheinwerfer Dach"};
local valuestrings = { "Hupe", "Fanfare", "Lied1", "Lied2", "Motor", "Motor2"};

local options = {
  { "Input", SOURCE},
  { "Name", STRING}
};

local function create(zone, options)
  local pie = { zone=zone, options=options};
  return pie;
end

local function update(pie, options)
  pie.options = options;
end

function refresh(pie, event)
--   local name = pie.options.Name;
   local value = getValue(pie.options.Input);
   lcd.drawSource(pie.zone.x, pie.zone.y, pie.options.Input, LEFT + SMLSIZE);
   lcd.drawNumber(pie.zone.x, pie.zone.y + 20, value, LEFT + SMLSIZE);
   lcd.drawText(pie.zone.x + 20, pie.zone.y + 20, " : ", LEFT + SMLSIZE);
   if (value > 0) and (value <= #valuestrings) then
      lcd.drawText(pie.zone.x + 40, pie.zone.y + 20, valuestrings[value], LEFT + SMLSIZE);
   else
      lcd.drawNumber(pie.zone.x + 40, pie.zone.y + 20, value, LEFT + SMLSIZE);
   end
end

return { name="IText", options=options, create=create, update=update, refresh=refresh};
