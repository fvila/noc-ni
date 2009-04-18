-----------------------------
-- Wormhole packet joiner
-- Francesc Vila
-----------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.net_types.all;

entity wormhole_joiner is
	port(
		reset	    : in  std_logic;
		clk		    : in  std_logic;
		flit_in	    : in  std_logic_vector(7 downto 0);
		ready	    : in  std_logic;
		packet_out  : out std_logic_vector(95 downto 0);
		done	    : out std_logic);
end;

architecture a of wormhole_joiner is
	signal fstart : integer range 0 to 95;
	signal fend	: integer range 0 to 90;
    signal pkt : std_logic_vector(95 downto 0);
begin
	process (clk, reset)
	begin
		if reset = '1' then
            fstart <= 95;
            fend <= 90;
            done <= '0';
            pkt <= (others => '0');
		elsif clk'event and clk = '1' then
			if fstart = 0 and fend = 0 then
				-- We aren't initialized
				null;
			else
				if ready = '1' then
                    pkt(fstart downto fend) <= flit_in(5 downto 0);
                    if fend = 0 then
                        -- It is the last flit
                        done <= '0';
                    else
                        fstart <= fstart - 6;
                        fend <= fend - 6;
                    end if;
				else
					-- We have to wait for new flits
					null;
				end if;
			end if;
		end if;
	end process;

    packet_out <= pkt;
end architecture;
