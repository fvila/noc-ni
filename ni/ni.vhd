-------------------------------------------------------------------------------
--  Network interface design
--  Francesc Vila
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
use work.config.all;
use work.net_types.all;

entity ni is
	generic (
		NSLV		: integer := 0;
        NMST        : integer := 0;
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
		ack			: in  std_logic			-- For debug purposes
	);
end;

architecture behavioural of ni is
    component type_gen is
        port (
            htran   : in  std_logic_vector(1 downto 0);
            hwrite  : in  std_logic;
            hburst  : in  std_logic_vector(2 downto 0);
            pkt_type: out std_logic_vector(7 downto 0));
    end component;

    component ni_state_slv is
        port (
            clk     : in  std_logic;
            resetn  : in  std_logic;
            hsel    : in  std_logic;
            htrans  : in  std_logic_vector(1 downto 0);
            ack     : in  std_logic;
			hready 	: out std_logic;
			inc		: out std_logic;
			start_flit : out std_logic);
    end component;

	component packetizer is
		generic (
			SRC_ADDR	: std_logic_vector(15 downto 0) := (others => '0')
		);
		port (
			slvin	: in  ahb_slv_in_type;
			n_pkt	: in  std_logic_vector(15 downto 0);
			flags	: in  std_logic_vector(7 downto 0);
			pkt_out	: out std_logic_vector(95 downto 0));
	end component;

	component counter is
		port (
			resetn	: in  std_logic;
			inc		: in  std_logic;
			value	: out std_logic_vector(15 downto 0));
	end component;

	component wormhole_splitter is
		port(
			reset	: in  std_logic;
			clk		: in  std_logic;
			pkt		: in  std_logic_vector(95 downto 0);
			ready	: in  std_logic;
			flit_out: out std_logic_vector(7 downto 0);
			done	: out std_logic;
            ncon    : out std_logic);
	end component;

--    signal ack : std_logic;
	signal pkt_type : std_logic_vector(7 downto 0);
	signal pkt_out	: std_logic_vector(95 downto 0);
	signal n_pkt : std_logic_vector(15 downto 0);
	signal inc 	: std_logic;
	signal start_flit : std_logic;
	signal flit_out	: std_logic_vector(7 downto 0);
	signal flit_done : std_logic;

begin
    tg0: type_gen
        port map (
            htran => slave_in.htrans,
            hwrite => slave_in.hwrite,
            hburst => slave_in.hburst,
			pkt_type => pkt_type);

    slv0: ni_state_slv
        port map (
            clk => clk,
            resetn => resetn,
            hsel => slave_in.hsel(NSLV),
            htrans => slave_in.htrans,
            ack => ack,
			hready => slave_out.hready,
			inc => inc,
			start_flit => start_flit);

	pkt0: packetizer
		generic map (SRC_ADDR => SRC_ADDR)
		port map (
			slvin => slave_in,
			n_pkt => n_pkt,
			flags => pkt_type,
			pkt_out => pkt_out);

	cnt0: counter
		port map (
			resetn => resetn,
			inc => inc,
			value => n_pkt);
	
	whs0: wormhole_splitter
		port map (
			reset => start_flit,
			clk => clk,
			pkt => pkt_out,
			ready => net_in.rok,
			flit_out => net_out.packet_out,
			done => net_out.rfin,
            ncon => net_out.rcon);

    -- Config registers for plug&play
    slave_out.hconfig(0) <= VENDOR & DEVICE_ID & "00" & VERSION & IRQ;
    slave_out.hconfig(1) <= x"00000000";
    slave_out.hconfig(2) <= x"00000000";
    slave_out.hconfig(3) <= x"00000000";
    slave_out.hconfig(4) <= x"00000000";
    slave_out.hconfig(5) <= x"00000000";
    slave_out.hconfig(6) <= x"00000000";
    slave_out.hconfig(7) <= x"00000000";
    slave_out.hindex <= NSLV;

end;
