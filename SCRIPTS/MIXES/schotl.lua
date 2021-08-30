--
-- WM OTXE - OpenTX Extensions 
-- Copyright (C) 2020 Wilhelm Meier <wilhelm.wm.meier@googlemail.com>
--
-- This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
-- To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ 
-- or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

local input = {
   {"Eing A1", SOURCE},
   {"Eing B1", SOURCE},
   {"Eing A2", SOURCE},
   {"Eing B2", SOURCE}
};

local output = { "SchottPow 1",
		 "SchottDir 1",
		 "SchottPow 2",
		 "SchottDir 2"
};

local function run(a1, b1, a2, b2)
   local SchottelPow1 = math.sqrt(a1 * a1 + b1 * b1) / 1.41421;
   local SchottelDir1 = 0;
   if (SchottelPow1 > 10) then
      SchottelDir1 = math.atan2(b1, a1) * 1024 / math.pi;
   end
   local SchottelPow2 = math.sqrt(a2 * a2 + b2 * b2) / 1.41421;
   local SchottelDir2 = 0;
   if (SchottelPow2 > 10) then
      SchottelDir2 = math.atan2(b2, a2) * 1024 / math.pi;
   end
   return SchottelPow1, SchottelDir1, SchottelPow2, SchottelDir2;
end

return {input=input, run=run, output=output}

