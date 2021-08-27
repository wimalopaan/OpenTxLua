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


local options = {
  { "Offset", VALUE, 0, 0, 49},
  { "Value1", SOURCE, 1},
  { "Value2", SOURCE, 2},
  { "Value3", SOURCE, 3},
};

local function create(zone, options)
  setSerialBaudrate(115200);
  local pie = { zone=zone, options=options};
  return pie;
end

local function update(pie, options)
  pie.options = options;
end

local function background(pie)
   local off = pie.options.Offset;
   local v1 = getValue(pie.options.Value1);
   local v2 = getValue(pie.options.Value2);
   local v3 = getValue(pie.options.Value3);
   serialWrite("$w" .. off .. ":" .. v1 .. ":" .. v2 .. ":" .. v3 .."\n");
end

function refresh(pie, event)
   local off = pie.options.Offset;
   lcd.drawText(pie.zone.x, pie.zone.y, "DeskSend W [" .. off .. "]", SMLSIZE);
   --   lcd.drawNumber(pie.zone.x, pie.zone.y + 10, off, MIDSIZE);
   lcd.drawSource(pie.zone.x,      pie.zone.y + 16, pie.options.Value1, SMLSIZE);
   lcd.drawSource(pie.zone.x + 30, pie.zone.y + 16, pie.options.Value2, SMLSIZE);
   lcd.drawSource(pie.zone.x + 60, pie.zone.y + 16, pie.options.Value3, SMLSIZE);
end

return { name="DeskSendW", options=options, create=create, update=update, refresh=refresh, background=background };
