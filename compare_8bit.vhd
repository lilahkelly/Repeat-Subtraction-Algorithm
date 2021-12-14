library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compare_8bit is 
port (A, B: in std_logic_vector(7 downto 0);
      lt, eq, gt: out std_logic);
end compare_8bit;
      
architecture dataflow of compare_8bit is

begin
process(A, B) is
begin
   if (A = B) then
       eq <= '1';
       lt <= '0';
       gt <= '0';
   elsif (A > B) then
       eq <= '0';
       lt <= '0';
       gt <= '1';
   elsif (A < B) then
       eq <= '0';
       lt <= '1';
       gt <= '0';
       end if;
end process;
end dataflow;