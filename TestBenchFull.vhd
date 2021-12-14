-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity HLSMfull_tb is
end HLSMfull_tb;

architecture tb of HLSMfull_tb is
constant CLK_PERIOD : time := 20 ns;

--component HLSM is
--port (start, Clk, reset: in std_logic;
--		Done, Zero_Flag: out std_logic;
--        N, D: in std_logic_vector(7 downto 0);
--        R, Q: out std_logic_vector(7 downto 0));
--end component;

component Divider is
port (start: in std_logic;
	clk, reset: in std_logic;
    N, D: in std_logic_vector(7 downto 0);
    Q, R: out std_logic_vector(7 downto 0);
    Zero_flag, done: out std_logic);
end component;

signal clk_tb, start_tb, reset_tb: std_logic := '0';
signal Done_tb, Zero_Flag_tb: std_logic;
signal N_tb, D_tb: std_logic_vector(7 downto 0);
signal R_tb, Q_tb: std_logic_vector(7 downto 0);
signal StopClk: BOOLEAN := False;
signal N_int, D_int, Q_int, R_int: integer := 0; --integer versions to provide comparison product

begin
DUT: Divider port map (start_tb, clk_tb, reset_tb, N_tb, D_tb, Q_tb, R_tb, Zero_Flag_tb, Done_tb);

-- Generate clock
	process begin
      while not StopClk loop
		clk_tb <= '0';
		wait for CLK_PERIOD/2;
		clk_tb <= '1';
		wait for CLK_PERIOD/2;
      end loop;
      wait;
	end process;
 
N_tb <=  std_logic_vector(to_unsigned(N_int, 8));
D_tb <=  std_logic_vector(to_unsigned(D_int, 8)); 
D_int <= 5;
Q_int <=  N_int/5;
R_int <=   N_int mod 5;

	process begin

    for i in 0 to 173 loop     
        if (N_int = 173) then  
            N_int <= 0;
        else 
            N_int <= i;
        end if;
        wait for CLK_PERIOD * 2;
        start_tb <= '1';
        wait until (done_tb = '1');
        wait for CLK_PERIOD;
        report (to_string(to_unsigned(N_int,8))) severity note;
        report (to_string(to_unsigned(D_int,8))) severity note;
        assert (Q_tb = (std_logic_vector(to_unsigned(Q_int,8)))) 
                report "test failed" severity failure;
        assert (R_tb = (std_logic_vector(to_unsigned(R_int,8)))) 
                report "test failed" severity failure;
-- Here is where we wait af
      	start_tb <= '0';-- now lower start
        wait for CLK_PERIOD;
      end loop; 
      
      wait for CLK_PERIOD;       
        StopClk <= True;
      wait;
	end process; 
end tb;