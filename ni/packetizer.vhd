library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
use work.config.all;
use work.net_types.all;

entity packetizer is
	generic (
		SRC_ADDR	: std_logic_vector(15 downto 0) := (others => '0')
	);
	port (
		slvin	: in  ahb_slv_in_type;
		n_pkt	: in  std_logic_vector(15 downto 0);
		flags	: in  std_logic_vector(7 downto 0);
		pkt_out	: out std_logic_vector(95 downto 0));
end;

architecture a of packetizer is
begin
	process (slvin)
		variable pkt	: std_logic_vector(95 downto 0);
	begin
		pkt := SRC_ADDR & slvin.haddr(15 downto 0) &
			n_pkt & "00000" & slvin.hsize & flags &
			slvin.hwdata;

		pkt_out <= pkt;
	end process;
end;
