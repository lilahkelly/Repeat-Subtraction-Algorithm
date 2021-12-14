-- 4-bit 4x1 mux model with case when
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mux2x1 is
port(Sel:in std_logic;
     D0, D1:in std_logic_vector(7 downto 0);
	 F: out std_logic_vector(7 downto 0));
end Mux2x1;

architecture in_class of Mux2x1 is
begin
  process(D0, D1, Sel) begin
    if (Sel = '0') then
		F <= D0;
    elsif (Sel = '1') then
		F <= D1;
    end if;
  end process;
end in_class;