--
-- WM OTXE - OpenTX Extensions 
-- Copyright (C) 2020 Wilhelm Meier <wilhelm.wm.meier@googlemail.com>
--

-- This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
-- To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ 
-- or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

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

function refresh(pie, event)
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
