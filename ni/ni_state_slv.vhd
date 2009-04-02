------------------------------------
-- Network interface state machine
-- Francesc Vila
------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
use work.config.all;
use work.net_types.all;

entity ni_state_slv is
    port (
        clk     	: in  std_logic;
        resetn  	: in  std_logic;
        hsel    	: in  std_logic;
        htrans  	: in  std_logic_vector(1 downto 0);
        ack     	: in  std_logic;
		hready		: out std_logic;
		inc			: out std_logic;
		start_flit	: out std_logic
    );
end;

architecture a of ni_state_slv is

    -- Different states for the state machine
    constant STATE_INI      : std_logic_vector(1 downto 0) := "00";
    constant STATE_NONSEQ   : std_logic_vector(1 downto 0) := "01";
    constant STATE_SEQ      : std_logic_vector(1 downto 0) := "10";
    constant STATE_WAIT     : std_logic_vector(1 downto 0) := "11";

    signal curr_state, next_state : std_logic_vector(1 downto 0);
begin

    slv_seq : process (clk, resetn)
    begin
        if resetn = '0' then
            curr_state <= STATE_INI;
        elsif clk'event and clk = '1' then
            curr_state <= next_state;
        end if;
    end process slv_seq;

    slv_com : process (curr_state, hsel, htrans, ack)
    begin
        case curr_state is
            when STATE_INI =>
                if hsel = '1' and htrans = HTRANS_SEQ then
                    next_state <= STATE_SEQ;
                elsif hsel = '1' and htrans = HTRANS_NONSEQ then
                    next_state <= STATE_NONSEQ;
                else
                    null;
                end if;
				hready <= '0';
				inc <= '1';
				start_flit <= '0';
            when STATE_NONSEQ =>
                next_state <= STATE_WAIT;
				inc <= '0';
				start_flit <= '1';
            when STATE_SEQ =>
                next_state <= STATE_WAIT;
				inc <= '0';
				start_flit <= '1';
            when STATE_WAIT =>
                if ack = '1' then
                    next_state <= STATE_INI;
					hready <= '1';
                else
                    null;
                end if;
				start_flit <= '0';
            when others =>
                null;
        end case;
    end process slv_com;
end;
