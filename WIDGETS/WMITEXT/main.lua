---- #########################################################################
---- #                                                                       #
---- # Copyright (C) OpenTX                                                  #
-----#                                                                       #
---- # License GPLv2: http://www.gnu.org/licenses/gpl-2.0.html               #
---- #                                                                       #
---- # This program is free software; you can redistribute it and/or modify  #
---- # it under the terms of the GNU General Public License version 2 as     #
---- # published by the Free Software Foundation.                            #
---- #                                                                       #
---- # This program is distributed in the hope that it will be useful        #
---- # but WITHOUT ANY WARRANTY; without even the implied warranty of        #
---- # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
---- # GNU General Public License for more details.                          #
---- #                                                                       #
---- #########################################################################


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

function refresh(pie)
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
