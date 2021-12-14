-- Code your design here
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subtractor_8Bit is 
port (A, B : in std_logic_vector(7 downto 0);
	S: out std_logic_vector(7 downto 0));
end subtractor_8Bit;


architecture impl of subtractor_8Bit is
signal a_unsigned : unsigned(7 downto 0);
signal b_unsigned : unsigned(7 downto 0);
signal sum: unsigned(7 downto 0);
begin
a_unsigned <= unsigned(A);
b_unsigned <= unsigned(B);
sum <= (a_unsigned) - (b_unsigned);
S <= std_logic_vector(sum(7 downto 0));
end impl;

