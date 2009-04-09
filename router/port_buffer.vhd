----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:15:36 04/02/2009 
-- Design Name: 
-- Module Name:    port_buffer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity port_buffer is

	port (
		clk   	: in std_logic;
		rstn		: in std_logic;
		idata 	: in std_logic_vector(7 downto 0);
		av_in		: in std_logic; -- next buffer available
		val_in	: in std_logic; -- previous buffer valid
		
		odata 	: out std_logic_vector(7 downto 0);
		av_out	: out std_logic; -- available for write
		val_out	: out std_logic	-- valid contents
	);

end port_buffer;

architecture behav of port_buffer is

	signal data : std_logic_vector(7 downto 0);
	signal wr, re, val	: std_logic; -- val is equivalent with NOT empty
	
begin
	-- data in and data out --
	latching: process (clk, rstn) is
	begin
		if (rstn = '0') then
			data <= (others => '0');
		else
			if (clk'event AND clk = '1') then
				if wr = '1' then
					data <= idata;
				end if;
			end if;
		end if;
	end process;

	odata <= data;
	
	-- -- re and wr creation -- --
	-- re corresponds to a "pop" operation
	-- wr corresponds to a "push" operation
	
	wr <= val_in AND ( (NOT val) OR (val AND re) );
	
	re <= av_in;
	
	-- -- valid and available indicators -- --
	-- val and av combinations correspond to empty/full signals on a FIFO
	-- val is '1' when valid data (fresh or yet unread) is in the buffer
	-- av is '1' when data has been read or the buffer is empty/full with non-valid data
	
	valid_data: process (clk, rstn) is
	begin
		if (rstn = '0') then
			val <= '0';
		else
			if (clk'event AND clk = '1') then
				if wr = '1' then
					val <= '1';
				elsif re = '1' then
					val <= '0';
				end if;
			end if;
		end if;
	end process;
	
	val_out <= val;
	
	
	av_out <= (NOT val) OR re;
	
	
end behav;

