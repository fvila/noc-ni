------------------------------------------------------------------------------
--  LEON3 Demonstration design test bench
--  Copyright (C) 2004 Jiri Gaisler, Gaisler Research
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation; either version 2 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.stdlib.all;
use grlib.amba.all;
library gaisler;
use gaisler.libdcom.all;
use gaisler.sim.all;
use gaisler.jtagtst.all;
library techmap;
use techmap.gencomp.all;
library micron;
use micron.components.all;
use work.debug.all;

use work.config.all;	-- configuration
use work.net_types.all; -- Extra types

entity testbench_counter is
end;

architecture behav of testbench_counter is
	signal clk : std_logic;
    signal resetn : std_logic;
    signal value : std_logic_vector(15 downto 0);

    component counter is
    port (
        resetn     : in  std_logic;
        inc  : in  std_logic;
        value   : out std_logic_vector(15 downto 0)
    );
    end component;
begin

	i1: counter
		port map (resetn, clk, value);

    process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

	process
	begin
		
		resetn <= '0';
		wait for 3 ns;

		resetn <= '1';
        wait for 10 ns;       

		wait;
		
	end process;
end;
