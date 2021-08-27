--
-- WM OTXE - OpenTX Extensions 
-- Copyright (C) 2020 Wilhelm Meier <wilhelm.wm.meier@googlemail.com>
--
-- This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
-- To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ 
-- or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

local input = {
   {"Eing 1", SOURCE},
   {"Eing 2", SOURCE},
};

local output = { "SchottPow", "SchottDir" };

local SchottelDir = 0;
local SchottelPow = 0;

local function run(a, b)
   SchottelPow = math.sqrt(a * a + b * b) / 1.41;
   if (SchottelPow > 10) then
      SchottelDir = math.atan2(b, a) * 1024 / math.pi;
   else
      SchottelDir = 0;
   end
   return SchottelPow, SchottelDir;
end

return {input=input, run=run, output=output}

