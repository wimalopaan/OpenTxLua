--
-- WM OTXE - OpenTX Extensions 
-- Copyright (C) 2020 Wilhelm Meier <wilhelm.wm.meier@googlemail.com>
--
-- This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
-- To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ 
-- or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

local input = {
   {"Value 1", SOURCE},
   {"Value 2", SOURCE},
   {"Value 3", SOURCE},
   {"Value 4", SOURCE},
   {"Value 5", SOURCE}
};

local function run(v1, v2, v3, v4, v5)
   v1 = v1 + 1024;
   v2 = v2 + 1024;
   v3 = v3 + 1024;
   v4 = v4 + 1024;
   v5 = v5 + 1024;
   serialWrite("$p0:" .. v1 .. "\n");
   serialWrite("$p1:" .. v2 .. "\n");
   serialWrite("$p2:" .. v3 .. "\n");
   serialWrite("$p3:" .. v4 .. "\n");
   serialWrite("$p4:" .. v5 .. "\n");
end

return {input=input, run=run}

