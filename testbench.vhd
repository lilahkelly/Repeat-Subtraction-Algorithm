-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity HLSM_tb is
end HLSM_tb;

architecture tb of HLSM_tb is
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

begin
DUT: Divider port map (start_tb, clk_tb, reset_tb, N_tb, D_tb, R_tb, Q_tb, Zero_Flag_tb, Done_tb);

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
 
	process begin
		reset_tb <= '1'; -- first reset the register
      wait for CLK_PERIOD; 
		reset_tb <= '0'; --Testing 1/200
        N_tb <= "11001000";
        D_tb <= "00000101";
      wait for CLK_PERIOD;--wait to start
        start_tb <= '1';
      wait for CLK_PERIOD; 
		--Wait for to Fin1 
        
        
 
        start_tb <= '0';
      wait for CLK_PERIOD;   --Testing 5/0
        N_tb <= "00000101";
        D_tb <= "00000000";
      wait for CLK_PERIOD;--wait to start
        start_tb <= '1';
      wait for CLK_PERIOD; 
 		--Wait for Zero
        
        

        start_tb <= '0';
      wait for CLK_PERIOD; --Testing 255/2
        N_tb <= "11111111";
        D_tb <= "00000010";
      wait for CLK_PERIOD;--wait to start
        start_tb <= '1';
      wait for CLK_PERIOD * 128; 
 		--Wait for Divde
      wait for CLK_PERIOD;
      	--Wait for Fin2

 
        start_tb <= '0';
      wait for CLK_PERIOD;--Testing 255/1
        N_tb <= "11111111";
        D_tb <= "00000001";
      wait for CLK_PERIOD;--wait to start
        start_tb <= '1';
      wait for CLK_PERIOD; 
 		--Wait for One
        
      

        start_tb <= '0';
      wait for CLK_PERIOD; --Testing 255/255
        N_tb <= "11111111";
        D_tb <= "11111111";
      wait for CLK_PERIOD;--wait to start
        start_tb <= '1';
      wait for CLK_PERIOD; 
 		--Wait for Fin2
      
      
      wait for CLK_PERIOD;       
        StopClk <= True;
      wait;
	end process; 
end tb;