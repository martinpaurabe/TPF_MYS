----------------------------------------------------------------------------------
-- Company: FOCUS
-- Engineer: Martin Paura Bersan
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

entity LTC2145 is
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
        LTC2145_sdo  	    : in std_logic :='1'; --Serial Clk communication   
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
end LTC2145;

architecture LTC2145_arch of LTC2145 is
    
    signal internaCLK: std_logic := '0';
	signal STT: INTEGER range 0 to 15;
	
begin

clk_inst: process(LTC2145_clk_in)
        variable prescaler:natural:=0;
    begin  
        if rising_edge(LTC2145_clk_in) then
            if(LTC2145_rst = '0')then
                prescaler:=0;
            elsif(prescaler = prescaleFactor)then
                internaCLK <= not internaCLK;
                prescaler:=0;
            else --if(LTC2145_ena = '1')
                prescaler := prescaler +1;
            end if;
        end if;
    end process;


LTC2145_inst: process(LTC2145_clk_in) 
    begin
        if rising_edge (LTC2145_clk_in) then
            if (LTC2145_rst = '0') then 
                LTC2145_ENC   <= '0';
                LTC2145_nENC  <= '1';
                LTC2145_cc  <= '0';
                LTC2145_sclk  <= '0';
                STT <= 0;
                LTC2145_data1_reg <= (others=>'0');
                LTC2145_data2_reg <= (others=>'0');
            else
                case STT is
                    when 0 =>
                        if (LTC2145_ena = '1') then
                            LTC2145_ENC   <= '1';
                            LTC2145_nENC  <= '0';
                            STT <= 1;
                            LTC2145_cc  <= '0';
                        else
                            LTC2145_ENC   <= '0';
                            LTC2145_nENC  <= '1';
                            LTC2145_cc <= '0';
                            STT <= 0;		
                        end if;
                    when 1 =>
                        if(LTC2145_clkout = '1') then
                            LTC2145_data1_reg <= LTC2145_daout1;
                            LTC2145_data2_reg <= LTC2145_daout2;
                            STT <= 2;
                        end if;
                    when 2 =>
                        LTC2145_cc <= '1';
                        if (LTC2145_ena = '0') then
                            STT <= 0;
                        end if;
                    when others =>
                        STT <= 0;
                end case;
            end if;
        end if;
    end process;
end LTC2145_arch;