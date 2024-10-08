----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/28/2024 10:30:54 PM
-- Design Name: 
-- Module Name: arch_pl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.all;

library work;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LMX2594 is
    generic(
        prescaleFactor: natural:=10;
        N_signal: natural:=10000
    );
    Port ( 
        LMX2594_rst         : in  std_logic; --reset
        LMX2594_ena	        : in  std_logic; --enable   
        LMX2594_clk_in      : in std_logic;  --Input CLK 
        LMX2594_csb  	    : out std_logic :='1'; --Serial Clk communication   
        LMX2594_sclk	    : buffer std_logic :='0'; --Serial Clk communication   
        LMX2594_sdat	    : out std_logic:='0'; --Serial Data Output   
        LMX2594_smux	    : in std_logic;  --Serial Data Input  
        LMX2594_r_nw	    : in  std_logic; --Read-Not Write select (1 to read; 0 to write)
        LMX2594_addr	    : in  std_logic_vector (6 downto 0);  --register address
        LMX2594_data_tx     : in std_logic_vector (15 downto 0); --Data to be write
        LMX2594_data_rx     : out std_logic_vector (15 downto 0):=(others=>'0');  --Data to be read 
        LMX2594_cc          : out std_logic :='0'; --Comunication complete
        LMX2594_InitSync    : in  std_logic; --enable   
        LMX2594_SyncSignal  : out std_logic :='0'; --Comunication complete
        LMX2594_100MHz      : out std_logic :='0' --Comunication complete
    );
end LMX2594;

architecture LMX2594_arch of LMX2594 is
    
    signal internaCLK: std_logic := '0';
	signal BIT_CNT	: INTEGER range 0 to 32;
	signal STT: INTEGER range 0 to 15;
	signal LMX2594_addr_reg : std_logic_vector (6 downto 0);
	signal LMX2594_data_rx_reg : std_logic_vector (15 downto 0);
	signal LMX2594_data_tx_reg : std_logic_vector (15 downto 0);
	
begin


clk_inst: process(LMX2594_clk_in)
        variable prescaler:natural:=0;
    begin  
        if rising_edge(LMX2594_clk_in) then
            if(LMX2594_rst = '0')then
                prescaler:=0;
            elsif(prescaler = prescaleFactor)then
                internaCLK <= not internaCLK;
                prescaler:=0;
            else --if(LMX2594_ena = '1')
                prescaler := prescaler +1;
            end if;
        end if;
    end process;


LMX2594_inst: process(internaCLK) 
    begin
        if rising_edge (internaCLK) then
            if (LMX2594_rst = '0') then 
                BIT_CNT   <= 0;
                LMX2594_csb  <= '1';
                LMX2594_cc  <= '0';
                LMX2594_sclk  <= '0';
                LMX2594_sdat <= '1';
                STT <= 0;
                LMX2594_addr_reg <= (others=>'0');
                LMX2594_data_rx_reg <= (others=>'0');
                LMX2594_data_tx_reg <= (others=>'0');
            else
                case STT is
                    when 0 =>
                        BIT_CNT   <= 0;
                        LMX2594_cc  <= '0';
                        LMX2594_sclk  <= '0';
                        STT <= 0;
                        LMX2594_addr_reg <= (others=>'0');
                        LMX2594_data_tx_reg <= (others=>'0');
                        if (LMX2594_ena = '1') then
                            LMX2594_sdat <= LMX2594_r_nw;
                            LMX2594_addr_reg <= LMX2594_addr;
                            STT <= 1;
                            LMX2594_csb  <= '0';
                        else
                            LMX2594_sdat <= '1';
                            LMX2594_csb  <= '1';
                            STT <= 0;		
                        end if;
                    when 1 =>
                        LMX2594_sclk <= not LMX2594_sclk;
                        if (LMX2594_sclk = '1') then
                            LMX2594_sdat <= LMX2594_addr_reg(6);
                            LMX2594_addr_reg <= LMX2594_addr_reg(5 downto 0) & '0';
                            BIT_CNT <= BIT_CNT +1;
                            if BIT_CNT = 6 then
                                LMX2594_data_tx_reg <= LMX2594_data_tx;
                                BIT_CNT <= 0;
                                STT <= 2;
                            end if;
                        elsif LMX2594_sclk = '0' then
                        end if;
                    when 2 =>
                        LMX2594_sclk <= not LMX2594_sclk;
                        if (LMX2594_sclk = '1') then
                            LMX2594_sdat <= LMX2594_data_tx_reg(15);
                            LMX2594_data_tx_reg <= LMX2594_data_tx_reg(14 downto 0) & '0';
                            LMX2594_data_rx_reg <= LMX2594_data_rx_reg (14 downto 0) & LMX2594_smux;
                            BIT_CNT <= BIT_CNT +1;
                            if BIT_CNT = 16 then
                                BIT_CNT <= 0;
                                STT <= 3;
                            end IF;
                        elsif (LMX2594_sclk = '0') then
                        end IF;
                    when 3 =>
                        LMX2594_data_rx <= LMX2594_data_rx_reg;
                        LMX2594_sclk <= '0';
                        LMX2594_cc <= '1';
                        STT <= 0;
                    when others =>
                        STT <= 0;
                end case;
            end if;
        end if;
    end process;
    
genEna_inst:    entity work.genEna
	generic map(
		N => N_signal
	)
	port map(
		clk_i => LMX2594_clk_in,
		rst_i => LMX2594_rst,
		ena_i => LMX2594_InitSync,
		q_o => LMX2594_SyncSignal
	);

Sint_Clk_inst: process(LMX2594_clk_in)
--aca se colocan las variables
begin
    if (LMX2594_rst = '0') then 
        LMX2594_100MHz <= '0';
    else
        LMX2594_100MHz <= LMX2594_clk_in;
    end if;
end process;
   
    
end LMX2594_arch;