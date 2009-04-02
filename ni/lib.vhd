library ieee;
use ieee.std_logic_1164.all;

package net_types is
	-- Signals from router to NI
	type net_ni_in_type is record
		packet_in	: std_logic_vector(7 downto 0);	    -- Packet bus
		rok			: std_logic;						-- Router is ready
		rerr		: std_logic;						-- Error from router
		ncon		: std_logic;						-- Router requests connection
		nfin		: std_logic;						-- Router finishes connection
	end record;

	-- Signals from NI to router
	type net_ni_out_type is record
		packet_out	: std_logic_vector(7 downto 0);	    -- Packet bus
		rcon		: std_logic;						-- Request connection to router
		rfin		: std_logic;						-- NI finishes transfer
		nok			: std_logic;						-- NI is ready
		nerr		: std_logic;						-- Error in NI
	end record;

	-- Flags constants
	constant INIT_TYPE 		: std_logic_vector(7 downto 0) := "00000001";
	constant ACK_TYPE 		: std_logic_vector(7 downto 0) := "00000010";
	constant READ_TYPE 		: std_logic_vector(7 downto 0) := "00000000";
	constant WRITE_TYPE 	: std_logic_vector(7 downto 0) := "00000100";
	constant WRAP4_TYPE		: std_logic_vector(7 downto 0) := "00001000";
	constant WRAP8_TYPE		: std_logic_vector(7 downto 0) := "00010000";
	constant WRAP16_TYPE	: std_logic_vector(7 downto 0) := "00100000";

	-- Flit types
	constant FLIT_START		: std_logic_vector(1 downto 0) := "10";
	constant FLIT_MIDDLE	: std_logic_vector(1 downto 0) := "00";
	constant FLIT_END		: std_logic_vector(1 downto 0) := "01";

    -- AMBA plug&play configuration
    constant VENDOR         : std_logic_vector(7 downto 0) := x"09";
    constant DEVICE_ID      : std_logic_vector(11 downto 0) := "000000000011";
    constant VERSION        : std_logic_vector(4 downto 0) := "00000";
    constant IRQ            : std_logic_vector(4 downto 0) := "00001";

end net_types;

