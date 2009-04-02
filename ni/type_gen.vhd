--------------------------
-- Type generator module
-- Francesc Vila
--------------------------

library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
use work.net_types.all;

entity type_gen is 
	port (
		htran	: in  std_logic_vector(1 downto 0);
		hwrite	: in  std_logic;
		hburst	: in  std_logic_vector(2 downto 0);
		pkt_type: out std_logic_vector(7 downto 0));
end;

architecture a of type_gen is
begin
	proc: process (htran, hwrite, hburst)
		variable pkt : std_logic_vector(7 downto 0);
	begin

		pkt := (others => '0');

		if htran = HTRANS_NONSEQ then
			pkt := pkt or INIT_TYPE;
		else
			null;
		end if;

		if hwrite = '1' then
			pkt := pkt or WRITE_TYPE;
		else
			pkt := pkt or READ_TYPE;
		end if;

		case hburst is
			when "010" => 
				pkt := pkt or WRAP4_TYPE;
			when "100" => 
				pkt := pkt or WRAP8_TYPE;
			when "110" => 
				pkt := pkt or WRAP16_TYPE;
			when others => 
				null;
		end case;

		pkt_type <= pkt;

	end process proc;
end;
