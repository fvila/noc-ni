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

entity testbench_test is
end;

architecture behav of testbench_test is
	signal htran : std_logic_vector (1 downto 0);
	signal hburst : std_logic_vector (2 downto 0);
	signal hwrite : std_logic;
	signal pkt_type : std_logic_vector (7 downto 0);

    component ni_state_slv is
    port (
        clk     : in  std_logic;
        resetn  : in  std_logic;
        hsel    : in  std_logic;
        htrans  : in  std_logic_vector(1 downto 0);
        hburst  : in  std_logic_vector(2 downto 0);
        ack     : in  std_logic
    );
    end component;

begin

	i1: ni_state_slv
		port map (htran, hwrite, hburst, pkt_type);
	process
	begin
		htran <= HTRANS_IDLE;
		hburst <= HBURST_SINGLE;
		hwrite <= '0';

		wait for 10 ns;

		hwrite <= '1';

		wait for 10 ns;

		htran <= HTRANS_SEQ;

		wait for 10 ns;

		htran <= HTRANS_NONSEQ;

		wait for 10 ns;

      htran <= HTRANS_SEQ;

		hburst <= HBURST_WRAP4;
		wait for 10 ns;
		hburst <= HBURST_WRAP8;
		wait for 10 ns;
		hburst <= HBURST_WRAP16;
		wait for 10 ns;

		wait;
		
	end process;
end;
