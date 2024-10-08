library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LMX2594_CTRL_IP is
	generic (
		-- Users to add parameters here
        prescaleFactor: natural:=10;
        N_signal: natural:=10000;

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S_AXI
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
        LMX2594_csb  	    : out std_logic :='1'; --Serial Clk communication   
        LMX2594_sclk	    : buffer std_logic :='0'; --Serial Clk communication   
        LMX2594_sdat	    : out std_logic:='0'; --Serial Data Output   
        LMX2594_smux	    : in std_logic;  --Serial Data Input  
        LMX2594_cc          : out std_logic :='0'; --Comunication complete
        LMX2594_SyncSignal  : out std_logic :='0'; --Comunication complete
        LMX2594_100MHz      : out std_logic :='0'; --Comunication complete


		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S_AXI
		s_axi_aclk	: in std_logic;
		s_axi_aresetn	: in std_logic;
		s_axi_awaddr	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_awprot	: in std_logic_vector(2 downto 0);
		s_axi_awvalid	: in std_logic;
		s_axi_awready	: out std_logic;
		s_axi_wdata	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		s_axi_wstrb	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		s_axi_wvalid	: in std_logic;
		s_axi_wready	: out std_logic;
		s_axi_bresp	: out std_logic_vector(1 downto 0);
		s_axi_bvalid	: out std_logic;
		s_axi_bready	: in std_logic;
		s_axi_araddr	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_arprot	: in std_logic_vector(2 downto 0);
		s_axi_arvalid	: in std_logic;
		s_axi_arready	: out std_logic;
		s_axi_rdata	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		s_axi_rresp	: out std_logic_vector(1 downto 0);
		s_axi_rvalid	: out std_logic;
		s_axi_rready	: in std_logic
	);
end LMX2594_CTRL_IP;

architecture arch_imp of LMX2594_CTRL_IP is

	-- component declaration
	component LMX2594_CTRL_IP_slave_lite_v1_0_S_AXI is
		generic (
        prescaleFactor: natural:=1000;
        N_signal: natural:=4;
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
        LMX2594_csb  	    : out std_logic :='1'; --Serial Clk communication   
        LMX2594_sclk	    : buffer std_logic :='0'; --Serial Clk communication   
        LMX2594_sdat	    : out std_logic:='0'; --Serial Data Output   
        LMX2594_smux	    : in std_logic;  --Serial Data Input  
        LMX2594_cc          : out std_logic :='0'; --Comunication complete
        LMX2594_SyncSignal      : out std_logic :='0'; --Sync Signal Initial Chirp
        LMX2594_100MHz          : out std_logic :='0'; --Clk for sintetizer works
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component LMX2594_CTRL_IP_slave_lite_v1_0_S_AXI;

begin

-- Instantiation of Axi Bus Interface S_AXI
LMX2594_CTRL_IP_slave_lite_v1_0_S_AXI_inst : LMX2594_CTRL_IP_slave_lite_v1_0_S_AXI
	generic map (
	    prescaleFactor     => prescaleFactor,
	    N_signal => N_signal,
		C_S_AXI_DATA_WIDTH	=> C_S_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S_AXI_ADDR_WIDTH
	)
	port map (
        LMX2594_csb     => LMX2594_csb, --   	    : out std_logic :='1'; --Serial Clk communication   
        LMX2594_sclk    => LMX2594_sclk, --	    : buffer std_logic :='0'; --Serial Clk communication   
        LMX2594_sdat	=> LMX2594_sdat, --   : out std_logic:='0'; --Serial Data Output   
        LMX2594_smux    => LMX2594_smux, --	    : in std_logic;  --Serial Data Input  
        LMX2594_cc      => LMX2594_cc, --    : out std_logic :='0'; --Comunication complete
        LMX2594_SyncSignal =>   LMX2594_SyncSignal, --      : out std_logic :='0'; --Comunication complete
        LMX2594_100MHz => LMX2594_100MHz, --        : out std_logic :='0' --Comunication complete
        S_AXI_ACLK	=> s_axi_aclk,
		S_AXI_ARESETN	=> s_axi_aresetn,
		S_AXI_AWADDR	=> s_axi_awaddr,
		S_AXI_AWPROT	=> s_axi_awprot,
		S_AXI_AWVALID	=> s_axi_awvalid,
		S_AXI_AWREADY	=> s_axi_awready,
		S_AXI_WDATA	=> s_axi_wdata,
		S_AXI_WSTRB	=> s_axi_wstrb,
		S_AXI_WVALID	=> s_axi_wvalid,
		S_AXI_WREADY	=> s_axi_wready,
		S_AXI_BRESP	=> s_axi_bresp,
		S_AXI_BVALID	=> s_axi_bvalid,
		S_AXI_BREADY	=> s_axi_bready,
		S_AXI_ARADDR	=> s_axi_araddr,
		S_AXI_ARPROT	=> s_axi_arprot,
		S_AXI_ARVALID	=> s_axi_arvalid,
		S_AXI_ARREADY	=> s_axi_arready,
		S_AXI_RDATA	=> s_axi_rdata,
		S_AXI_RRESP	=> s_axi_rresp,
		S_AXI_RVALID	=> s_axi_rvalid,
		S_AXI_RREADY	=> s_axi_rready
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
