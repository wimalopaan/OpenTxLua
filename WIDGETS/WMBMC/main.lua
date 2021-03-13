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


local param_strings = {"Deadband", "Freq 1", "Freq 2", "Throttle 1", "Throttle 2", "Kick Thr", "Kick Time", "Min Throttle", "Slowdown", "SPortID", "NSensors", "Reset"};
local state_strings = {"Choose", "Set", "Test Run", "Run"};
local subst_strings = {"Off", "Forward HF", "Forward Gov", "Forward LF", "Backward HF", "Backward Gov", "Backward LF"};

local options = {
  { "State", SOURCE, 1}
};

local function create(zone, options)
  local pie = { zone=zone, options=options};
  return pie;
end

local function update(pie, options)
  pie.options = options;
end

function refresh(pie)
   local value = getValue(pie.options.State);
   local new_value = value % 10;
   value = math.floor(value / 10);
   local actual_value = value % 10;
   value = math.floor(value / 10);
   local param_value = value % 100 + 1;
   value = math.floor(value / 100);
   local state_value = value % 10;
   
   lcd.drawText(pie.zone.x, pie.zone.y, "State:", LEFT + MIDSIZE);
   lcd.drawNumber(pie.zone.x + 70, pie.zone.y, state_value, LEFT + MIDSIZE);
   if (state_value > 0) and (state_value <= #state_strings) then
      lcd.drawText(pie.zone.x + 90, pie.zone.y, state_strings[state_value], LEFT);
   end
   if (state_value < 4) then
      if (param_value > 0) and (param_value <= #param_strings) then
	 lcd.drawText(pie.zone.x, pie.zone.y + 30, param_strings[param_value], LEFT + SMLSIZE);
	 lcd.drawText(pie.zone.x,         pie.zone.y + 50, "Act:", LEFT + SMLSIZE);
	 lcd.drawNumber(pie.zone.x + 30,  pie.zone.y + 50, actual_value, LEFT + SMLSIZE);
	 lcd.drawText(pie.zone.x + 45,    pie.zone.y + 50, "New:", LEFT + SMLSIZE);
	 lcd.drawNumber(pie.zone.x + 80,  pie.zone.y + 50, new_value, LEFT + SMLSIZE);
      end
   else
      if (new_value > 0) and (new_value <= #subst_strings) then
	 lcd.drawText(pie.zone.x, pie.zone.y + 50, subst_strings[new_value], LEFT);
      end
   end
end

return { name="WM BMC", options=options, create=create, update=update, refresh=refresh};
