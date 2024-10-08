library IEEE;
use IEEE.std_logic_1164.all;

entity LTC2145_tb is

end LTC2145_tb;

architecture LTC2145_tb_arch of LTC2145_tb is

	component LTC2145 is
		generic(
			prescaleFactor: natural:=1
		);
		Port ( 
			LTC2145_rst         : in  std_logic; --reset
			LTC2145_ena	        : in  std_logic; --enable   
			LTC2145_clk_in      : in std_logic;  --Input CLK 
			LTC2145_par_nser    : out std_logic :='1'; --Serial Clk communication   
			LTC2145_cs  	    : out std_logic :='1'; --Serial Clk communication     
			LTC2145_sdi  	    : out std_logic :='1'; --Serial Clk communication   
			LTC2145_sdo  	    : out std_logic :='1'; --Serial Clk communication   
			LTC2145_sclk	    : buffer std_logic :='0'; --Serial Clk communication   
			LTC2145_cc          : out std_logic;  --convertion complete signal to PS 
			LTC2145_daout1      : in std_logic_vector(13 downto 0) := (others=>'0'); --paralel measurement Data Output   
			LTC2145_daout2      : in std_logic_vector(13 downto 0) := (others=>'0'); --paralel measurement Data Output   
			LTC2145_ENC	        : out std_logic;  --Enable Conversion  
			LTC2145_nENC	    : out std_logic;  --Negative Enable Conversion  
			LTC2145_clkout      : in std_logic;  --Convertion complete 
			LTC2145_nclkout	    : in std_logic;  --Negative convertion complete
			LTC2145_OF1	        : in std_logic;  --Overflow or underflow input from adc
			LTC2145_OF2	        : in std_logic;  --Overflow or underflow input from adc
			LTC2145_data1_reg   : out std_logic_vector(13 downto 0) := (others=>'0');
			LTC2145_data2_reg   : out std_logic_vector(13 downto 0) := (others=>'0')
		);
	end component;
	

	constant Prescaler_tb	: natural:=1;
	constant N_Bis_Test: natural:=14;

	signal LTC2145_ena_tb		: std_logic :='0'; --enable   
	signal LTC2145_rst_tb     	: std_logic :='0'; --reset
	signal LTC2145_clk_in_tb  	: std_logic :='0';  --Input CLK 
	signal LTC2145_sclk_tb		: std_logic; --Serial Clk communication   
	signal LTC2145_signal1_tb	: std_logic_vector (13 downto 0) := "01010101010101";  --register address
	signal LTC2145_signal2_tb  	: std_logic_vector (13 downto 0) := "01010101010101"; --Data to be write
	signal LTC2145_DAC1_tb		: std_logic_vector (13 downto 0) := (others =>'0');  --register address
	signal LTC2145_DAC2_tb  	: std_logic_vector (13 downto 0) :=(others =>'0'); --Data to be write
	signal LTC2145_cc_tb      	: std_logic; --Comunication complete
	signal LTC2145_sdo_tb		:std_logic;
	signal LTC2145_ENC_tb		:std_logic;
	signal LTC2145_nENC_tb		:std_logic;
	signal LTC2145_clkout_tb	:std_logic := '0';
	signal LTC2145_nclkout_tb	:std_logic := '1';
	signal LTC2145_OF1_tb		:std_logic := '0';
	signal LTC2145_OF2_tb		:std_logic := '0';
	signal LTC2145_par_nser_tb 	:std_logic;
	signal LTC2145_cs_tb 		:std_logic;
	signal LTC2145_sdi_tb 		:std_logic;


begin

	LTC2145_rst_tb 		<= '1' after 10 ns;

EstimuloEnable: process
begin
	for i in 0 to 4 loop
	wait for 50 ns;
	LTC2145_ena_tb 	<= '1';							
	wait for 20 ns;
	LTC2145_ena_tb 	<= '0';	
	end loop;
end process;


	LTC2145_clkout_tb 		<= 	'1' after 55 ns,
								'0' after 80 ns,
								'1' after 105 ns,
								'0' after 130 ns,
								'1' after 155 ns,
								'0' after 180 ns,
								'1' after 205 ns,
								'0' after 230 ns,
								'1' after 255 ns,
								'0' after 280 ns;

	LTC2145_nclkout_tb <= not LTC2145_clkout_tb;

EstimuloSig: process
		type vect_Sig_sim is array(0 to 4) of std_logic_vector(N_Bis_Test-1 downto 0);
		variable vect_Signal1_Sim:vect_Sig_sim := (	"11110000111100","10101010101010","11001100110011","00000000000000","11111111111111");
		variable vect_Signal2_Sim:vect_Sig_sim := (	"11110000111100","11100011100011","11110000111111","11111111111111","00000000000000");
	begin
		for i in 0 to 4 loop
		wait for 50 ns;
		LTC2145_signal1_tb	<= vect_Signal1_Sim(i);							
		LTC2145_signal2_tb	<= vect_Signal2_Sim(i);	
	end loop;
end process;
	LTC2145_clk_in_tb 	<= not LTC2145_clk_in_tb after 4 ns; --clk de 125MHz

	
	DUT: LTC2145
		generic map(
			prescaleFactor => Prescaler_tb
		)
		Port map( 
			LTC2145_rst         => LTC2145_rst_tb,
			LTC2145_ena	        => LTC2145_ena_tb,  
			LTC2145_clk_in     => LTC2145_clk_in_tb,
			LTC2145_par_nser    => LTC2145_par_nser_tb,   
			LTC2145_cs  	    =>  LTC2145_cs_tb,    
			LTC2145_sdi  	   => 	LTC2145_sdi_tb,
			LTC2145_sdo  	    => LTC2145_sdo_tb,
			LTC2145_sclk	    =>  LTC2145_sclk_tb, 
			LTC2145_cc         => LTC2145_cc_tb,
			LTC2145_daout1      => LTC2145_signal1_tb, 
			LTC2145_daout2     => LTC2145_signal2_tb,
			LTC2145_ENC	       => LTC2145_ENC_tb,
			LTC2145_nENC	   => LTC2145_nENC_tb,
			LTC2145_clkout     =>LTC2145_clkout_tb, 
			LTC2145_nclkout	   =>LTC2145_nclkout_tb, 
			LTC2145_OF1	       => LTC2145_OF1_tb,
			LTC2145_OF2	       => LTC2145_OF2_tb,
			LTC2145_data1_reg  => LTC2145_DAC1_tb,
			LTC2145_data2_reg  => LTC2145_DAC2_tb
		);
end LTC2145_tb_arch;