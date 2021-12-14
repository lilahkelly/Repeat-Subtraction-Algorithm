-- D flip-flow with positive edge-triggered clock and synchronous reset
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity incrementor8bit is 
port (A : in std_logic_vector(7 downto 0);
      S: out std_logic_vector(7 downto 0));
end incrementor8bit;
      
architecture impl of incrementor8bit is
signal a_unsigned : unsigned(7 downto 0);
signal sum: unsigned(7 downto 0);

begin
a_unsigned <= unsigned(A);
sum <= a_unsigned + "00000001";
S <= std_logic_vector(sum(7 downto 0));
end impl;
