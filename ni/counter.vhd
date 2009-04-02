-------------------
-- Packet counter
-- Francesc Vila
-------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	port(
		resetn	: in  std_logic;
		inc		: in  std_logic;
		value	: out std_logic_vector(15 downto 0));
end;

architecture a of counter is
	signal n : integer range 0 to 65535;	-- 16 bit unsigned
begin
	process(inc)
	begin
		if (resetn = '0') then
			n <= 0;
		elsif inc'event and inc = '1' then
			n <= n + 1;
		end if;
	end process;

	value <= std_logic_vector(to_unsigned(n, 16));
end;
