--
-- WM OTXE - OpenTX Extensions 
-- Copyright (C) 2020 Wilhelm Meier <wilhelm.wm.meier@googlemail.com>
--
-- This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
-- To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ 
-- or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

npos0 = 0;

local input = {
   {"Input", SOURCE},
   {"Top",    VALUE, 0, 100, 0},
   {"Botton", VALUE, 0, 100, 0},
   {"Steps",  VALUE, 4, 12, 6},
   {"Middle", VALUE, 1, 2, 2} 
};

local output = { "NPos" }

local function run(source, top, bottom, steps, middle)
--   print(source);
   local delta = 2048 / (steps + middle);
   local lower = math.floor(steps / 2);
   local upper = steps + middle - lower;
   
   for i = 1,(steps + middle) do
      if (source <= (-1024 + i * delta)) then
	    npos0 = 0;
--	 print(i);
	 if (( i > lower) and (i <= upper)) then
	    return 0;
	 end
	 local odelta = (2048 - top - bottom) / (steps + middle);
	 return (2 * (i - 1) + 1) * delta / 2 + bottom - 1024;
      end
   end
   return 0;
end

return {input=input, output=output, run=run}

