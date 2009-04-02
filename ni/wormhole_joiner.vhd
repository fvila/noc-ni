-----------------------------
-- Wormhole packet splitter
-- Francesc Vila
-----------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.net_types.all;

entity wormhole_splitter is
	port(
		reset	: in  std_logic;
		clk		: in  std_logic;
		pkt		: in  std_logic_vector(95 downto 0);
		ready	: in  std_logic;
		flit_out: out std_logic_vector(7 downto 0);
		done	: out std_logic;
        ncon    : out std_logic);
end;

architecture a of wormhole_splitter is
	signal fstart : integer range 0 to 95;
	signal fend	: integer range 0 to 90;
begin
	process (clk, reset)
	begin
		if reset = '1' then
			fstart <= 95;
			fend <= 90;
			done <= '0';
            ncon <= '0';
		elsif clk'event and clk = '1' then
			if fstart = 0 and fend = 0 then
				-- We aren't initialized
				null;
			else
				if ready = '1' then
					if fstart = 95 then
						flit_out <= FLIT_START & pkt(fstart downto fend);
						fstart <= fstart - 6;
						fend <= fend - 6;
                        ncon <= '1';
					else
						if fend = 0 then
							flit_out <= FLIT_END & pkt(fstart downto fend);
							done <= '1';
                            ncon <= '0';
						else
							flit_out <= FLIT_MIDDLE & pkt(fstart downto fend);
							fstart <= fstart - 6;
							fend <= fend - 6;
						end if;
					end if;
				else
					-- We have to wait to send flits
					null;
				end if;
			end if;
		end if;
	end process;
end architecture;
