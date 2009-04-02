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

entity testbench_ni is
end;

architecture behav of testbench_ni is

	signal resetn 	: std_logic;
	signal clk		: std_logic;
	signal master_in : ahb_mst_in_type;
	signal master_out : ahb_mst_out_type;
	signal slave_in : ahb_slv_in_type;
	signal slave_out : ahb_slv_out_type;
	signal net_in : net_ni_in_type;
	signal net_out : net_ni_out_type;
	signal ack : std_logic;
	signal ready : std_logic;

	component ni is
		generic (
			NSLV		: integer := 0;
			SRC_ADDR	: std_logic_vector(15 downto 0) := (others => '0')
		);
		port (
			resetn		: in  std_logic;
			clk         : in  std_logic;
			master_in	: in  ahb_mst_in_type;
			master_out	: out ahb_mst_out_type;
			slave_in	: in  ahb_slv_in_type;
			slave_out	: out ahb_slv_out_type;
			net_in		: in  net_ni_in_type;
			net_out		: out net_ni_out_type;
			ack			: in  std_logic
		);
	end component;

begin

	i1: ni
		generic map ( 
			NSLV => 0,
			SRC_ADDR => x"ABCD")
		port map (resetn, clk, master_in, master_out, slave_in, slave_out,
				net_in, net_out, ack);

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
		ack <= '0';
		net_in.rok <= '1';
		wait for 3 ns;
		resetn <= '1';

		slave_in.hwdata <= x"DEADBEEF";
		slave_in.hsel(0) <= '1';
		slave_in.haddr <= x"ABCDEF12";
		slave_in.hwrite <= '1';
		slave_in.htrans <= HTRANS_NONSEQ;
		slave_in.hsize <= "000";

		wait for 40 ns;

		net_in.rok <= '0';

		wait for 40 ns;

		net_in.rok <= '1';

		wait for 600 ns;

		ack <= '1';
		slave_in.hsel(0) <= '0';

		wait;
		
	end process;
end;
