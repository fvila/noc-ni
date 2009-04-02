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
	signal htrans : std_logic_vector (1 downto 0);
	signal ack : std_logic;
	signal clk : std_logic;
    signal hsel: std_logic;
    signal resetn : std_logic;
    signal state : std_logic_vector(1 downto 0);

    component ni_state_slv is
    port (
        clk     : in  std_logic;
        resetn  : in  std_logic;
        hsel    : in  std_logic;
        htrans  : in  std_logic_vector(1 downto 0);
        ack     : in  std_logic;
        state   : out std_logic_vector(1 downto 0)
    );
    end component;
begin

	i1: ni_state_slv
		port map (clk, resetn, hsel, htrans, ack, state);

    process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

	process
	begin
		
        ack <= '0';
        hsel <= '0';
        htrans <= HTRANS_IDLE;
        resetn <= '0';
        wait for 3 ns;
        resetn <= '1';

        htrans <= HTRANS_SEQ;
        hsel <= '1';
        wait for 10 ns;
        hsel <= '0';

        wait for 30 ns;

        ack <= '1';
        wait for 10 ns;
        ack <= '0';

        wait for 10 ns;
 
        htrans <= HTRANS_NONSEQ;
        hsel <= '1';
        wait for 10 ns;
        hsel <= '0';

        wait for 30 ns;

        ack <= '1';
        wait for 10 ns;
        ack <= '0';

        wait for 10 ns;       

		wait;
		
	end process;
end;
