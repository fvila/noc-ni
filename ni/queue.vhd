-----------------
-- Packet queue
-----------------

library ieee;
use ieee.std_logic_1164,all;
use work.net_types.all;

entity queue is
    generic(
        SIZE    : integer:= 8,
        INDEX   : integer:= log2x(SIZE)
    )
    port (
        clk     : in  std_logic;
        resetn  : in  std_logic;
        pkt_in  : in  std_logic_vector(95 downto 0);
        sel     : in  std_logic_vector(INDEX-1 downto 0);  -- Look at log2x definition
        pkt_out : out std_logic_vector(95 downto 0));
        
end;

architecture a of queue is
    signal mem : array (0 to SIZE) of std_logic_vector(95 downto 0);
begin
    process (clk, resetn)
    begin
        if resetn = '0' then
            for i in mem'range
            loop
                mem(i) <= (others => '0');
            end loop;
        elsif clk'event and clk = '1' then
            -- Look at conversion types
            mem(sel) <= pkt_in;
        end if;
    end;

    -- Do I need separate selection indexes? (rd and wr)
    pkt_out <= mem(sel);    -- Look also at conversion functions
end;
