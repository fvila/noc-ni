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

entity testbench_wormhole is
end;

architecture behav of testbench_wormhole is

	signal resetn 	: std_logic;
	signal clk		: std_logic;
	signal pkt		: std_logic_vector(95 downto 0);
	signal pkt2		: std_logic_vector(95 downto 0);
	signal flit		: std_logic_vector(7 downto 0);
	signal done 	: std_logic;
    signal ncon     : std_logic;
    signal done2    : std_logic;
    signal ready    : std_logic;

	component wormhole_splitter is
		port(
			reset	: in  std_logic;
			clk		: in  std_logic;
			pkt		: in  std_logic_vector(95 downto 0);
            ready   : in  std_logic;
			flit_out: out std_logic_vector(7 downto 0);
			done	: out std_logic;
            ncon    : out std_logic);
	end component;

    component wormhole_joiner is
        port(
            reset	    : in  std_logic;
            clk		    : in  std_logic;
            flit_in	    : in  std_logic_vector(7 downto 0);
            ready	    : in  std_logic;
            packet_out  : out std_logic_vector(95 downto 0);
            done	    : out std_logic);
    end component;

begin

	i1: wormhole_splitter
		port map (resetn, clk, pkt, ready, flit, done, ncon);

    i2: wormhole_joiner
        port map (resetn, clk, flit, ncon, pkt2, done2);

	process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;
	
	process
	begin
		
		pkt <= "01010101010101010101010101010101" &
			"01010101010101010101010101010101" &
			"01010101010101010101010101010101";

		resetn <= '1';

		wait for 3 ns;

		resetn <= '0';
        ready <= '1';

		wait for 180 ns;

        assert (pkt = pkt2)
            report "The packets differ" severity error;

--		resetn <= '0';

--		wait for 2 ns;

--		resetn <= '1';

		wait;
		
	end process;
end;
