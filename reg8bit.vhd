library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg8bit is 
port (D : in std_logic_vector(7 downto 0);
      clk, reset, ld: in std_logic;
      Q: out std_logic_vector(7 downto 0));
end reg8bit;
      
architecture str of reg8bit is

 begin
      
	process(clk) -- flip-flop is ONLY sensitive to clock, not reset, and not D input
	begin
		if rising_edge(clk) then  -- rising_edge is a function defined in std_logic_1164
	        --reset has highest priority, so we check that first in our if statement
			if reset = '1' then
              Q <= "00000000";
			elsif ld = '1' then Q <= D; 
            end if;
        end if; -- If not rising edge, do not change Q at all
	end process;

 end str;