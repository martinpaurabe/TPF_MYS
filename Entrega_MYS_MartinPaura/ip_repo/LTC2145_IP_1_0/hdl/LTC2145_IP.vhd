library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LTC2145_IP is
	generic (
		-- Users to add parameters here
        prescaleFactor: natural:=1;

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S_AXI
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 5
	);
	port (
		-- Users to add ports here
        LTC2145_par_nser    : out std_logic :='1'; --Serial Clk communication   
        LTC2145_cs  	    : out std_logic :='1'; --Serial Clk communication     
        LTC2145_sdi  	    : out std_logic :='1'; --Serial Clk communication   
        LTC2145_sdo  	    : in std_logic :='1'; --Serial Clk communication   
        LTC2145_sclk	    : buffer std_logic :='0'; --Serial Clk communication   
        LTC2145_daout1      : in std_logic_vector(13 downto 0) := (others=>'0'); --paralel measurement Data Output   
        LTC2145_daout2      : in std_logic_vector(13 downto 0) := (others=>'0'); --paralel measurement Data Output   
        LTC2145_ENC	        : out std_logic;  --Enable Conversion  
        LTC2145_nENC	    : out std_logic;  --Negative Enable Conversion  
        LTC2145_clkout      : in std_logic;  --Convertion complete 
        LTC2145_nclkout	    : in std_logic;  --Negative convertion complete
        LTC2145_OF1	        : in std_logic;  --Overflow or underflow input from adc
        LTC2145_OF2	        : in std_logic;  --Overflow or underflow input from adc

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
end LTC2145_IP;

architecture arch_imp of LTC2145_IP is

	-- component declaration
	component LTC2145_IP_slave_lite_v1_0_S_AXI is
		generic (
		-- Users to add parameters here
        prescaleFactor: natural:=1;
		-- User parameters ends
        C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 5
		);
		port (
		-- Users to add ports here
        LTC2145_par_nser    : out std_logic :='1'; --Serial Clk communication   
        LTC2145_cs  	    : out std_logic :='1'; --Serial Clk communication     
        LTC2145_sdi  	    : out std_logic :='1'; --Serial Clk communication   
        LTC2145_sdo  	    : in std_logic :='1'; --Serial Clk communication   
        LTC2145_sclk	    : buffer std_logic :='0'; --Serial Clk communication   
        LTC2145_daout1      : in std_logic_vector(13 downto 0) := (others=>'0'); --paralel measurement Data Output   
        LTC2145_daout2      : in std_logic_vector(13 downto 0) := (others=>'0'); --paralel measurement Data Output   
        LTC2145_ENC	        : out std_logic;  --Enable Conversion  
        LTC2145_nENC	    : out std_logic;  --Negative Enable Conversion  
        LTC2145_clkout      : in std_logic;  --Convertion complete 
        LTC2145_nclkout	    : in std_logic;  --Negative convertion complete
        LTC2145_OF1	        : in std_logic;  --Overflow or underflow input from adc
        LTC2145_OF2	        : in std_logic;  --Overflow or underflow input from adc

		-- User ports ends
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
	end component LTC2145_IP_slave_lite_v1_0_S_AXI;

begin

-- Instantiation of Axi Bus Interface S_AXI
LTC2145_IP_slave_lite_v1_0_S_AXI_inst : LTC2145_IP_slave_lite_v1_0_S_AXI
	generic map (
		prescaleFactor => prescaleFactor,
		C_S_AXI_DATA_WIDTH	=> C_S_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S_AXI_ADDR_WIDTH
	)
	port map (
	
	    LTC2145_par_nser    => LTC2145_par_nser, -- Parallel no serial   
        LTC2145_cs  	    => LTC2145_cs,  
        LTC2145_sdi  	    => LTC2145_sdi,  
        LTC2145_sdo  	    => LTC2145_sdo,  
        LTC2145_sclk	    => LTC2145_sclk,  
        LTC2145_daout1      => LTC2145_daout1,
        LTC2145_daout2      => LTC2145_daout2,  
        LTC2145_ENC	        => LTC2145_ENC,
        LTC2145_nENC	    => LTC2145_nENC,
        LTC2145_clkout      => LTC2145_clkout,
        LTC2145_nclkout	    => LTC2145_nclkout,
        LTC2145_OF1	        => LTC2145_OF1,
        LTC2145_OF2	        => LTC2145_OF2,


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
