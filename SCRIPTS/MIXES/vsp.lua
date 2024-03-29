--
-- WM OTXE - OpenTX Extensions 
-- Copyright (C) 2020, 2021 Wilhelm Meier <wilhelm.wm.meier@googlemail.com>
--
-- This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
-- To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/ 
-- or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

local input = {
   {"Eing 1", SOURCE},
   {"Eing 2", SOURCE},
   {"Gew 1->2", VALUE, -100, 100, 0},
   {"Gew 2->1", VALUE, -100, 100, 0},
   {"VSP", VALUE, 1, 2, 1}
};

local output = { "VspSrv1", "VspSrv2" };

local function run(a, b, wa, wb, vsp)
   local ab = math.abs(a);
   local bb = math.abs(b);  
   local as = a + ((bb * wb) / 100);
   local asb = math.abs(as);
   local bs = b + ((ab * wa) / 100);
   local bsb = math.abs(bs);

   local rmax = 0;
   local Amax = 1024;
   local Bmax = 1024;
   
   if (as >= 0) then
      if (bs >= 0) then
	 if (asb >= bsb) then
	    if (wb > 0) then
	       Amax = 1024 + (1024 * wb) / 100;
	    end
	    Bmax = (bsb * Amax) / asb;
	 else
	    if (wa > 0) then
	       Bmax = 1024 + (1024 * wa) / 100;
	    end
	    Amax = (asb * Bmax) / bsb;
	 end
      else
	 if (asb >= bsb) then
	    if (wb > 0) then
	       Amax = 1024 + (1024 * wb) / 100;
	    end
	    Bmax = (bsb * Amax) / asb;
	 else
	    if (wa < 0) then
	       Bmax = 1024 + (-1024 * wa) / 100;
	    end
	    Amax = (asb * Bmax) / bsb;
	 end
      end
   else
      if (bs >= 0) then
	 if (asb >= bsb) then
	    if (wb < 0) then
	       Amax = 1024 + (-1024 * wb) / 100;
	    end
	    Bmax = (bsb * Amax) / asb;
	 else
	    if (wa > 0) then
	       Bmax = 1024 + (1024 * wa) / 100;
	    end
	    Amax = (asb * Bmax) / bsb;
	 end
      else
	 if (asb >= bsb) then
	    if (wb < 0) then
	       Amax = 1024 + (-1024 * wb) / 100;
	    end
	    Bmax = (bsb * Amax) / asb;
	 else
	    if (wa < 0) then
	       Bmax = 1024 + (-1024 * wa) / 100;
	    end
	    Amax = (asb * Bmax) / bsb;
	 end
      end
   end
   rmax = math.sqrt(Amax * Amax + Bmax * Bmax);

   local Vsp1 = (as * 1024) / rmax;
   local Vsp2 = (bs * 1024) / rmax;

   return Csp1, Vsp2;
   
end

return {input=input, run=run, output=output}

