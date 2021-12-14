-- Example FSM
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity HLSM is
port (start, Clk, reset: in std_logic;
		Done, Zero_Flag: out std_logic;
        N, D: in std_logic_vector(7 downto 0);
        R, Q: out std_logic_vector(7 downto 0));
end HLSM;


architecture fsm of HLSM is
 
signal Remainder, Quotient: unsigned(7 downto 0);

begin     
	process(clk)
	type EX_statetype is (Init, Divide, Zero, Fin1, Fin2, One);
	variable EX_state: EX_statetype;
	begin
		if rising_edge(clk) then
			--set the initial state on reset
			if reset = '1' then
				EX_state := Init;
			else 
			-- state transitions
			case EX_state is
				when Init =>
                	if (start = '0') then
                    	Ex_state := Init;
                    elsif (D = "00000000") then
                    	Ex_state := Zero;
                    elsif (D = "00000001") then
                    	Ex_state := One;
                    elsif (N < D) then
                    	Ex_state := Fin1;
                    else
                    	Ex_state := Divide;
                    end if;
				when Zero =>
                	if (start = '0') then
                    	Ex_state := Init;
                    else
                		Ex_state := Zero;
                    end if;
				when Fin1 =>
                	if (start = '0') then
                    	Ex_state := Init;
                    else
                		Ex_state := Fin1;
                    end if;
                when Divide =>
                	if (Remainder >= unsigned(D)) then
                    	Ex_state := Divide;
                    else
                    	Ex_state := Fin2;
                    end if;
                when Fin2 =>
                	if (start = '0') then
                    	Ex_state := Init;
                    else
                		Ex_state := Fin2;
                    end if;
                when One =>
                if (start = '0') then
                    	Ex_state := Init;
                    else
                		Ex_state := One;
                    end if;
                when others =>
                	Ex_state := Init;
			end case;
            end if;
		-- state output actions
			case EX_state is
				when Init =>
                	Remainder <= unsigned(N);
                    Quotient <= "00000000";
                    Zero_Flag <= '0'; 
                    Done <= '0';
                when Zero =>
                	Remainder <= "00000000";
                    Quotient <= "00000000";
                    Zero_Flag <= '1';
                    Done <= '1';
                when Fin1 =>
                	Remainder <= unsigned(N);
                    Quotient <= "00000000";
                    Zero_Flag <= '0';
                    Done <= '1';
                when Divide =>
                	Remainder <= Remainder - unsigned(D);
                    Quotient <= Quotient + "00000001";
                    Zero_Flag <= '0';
                    Done <= '0';
                When Fin2 =>
                	Remainder <= Remainder;
                    Quotient <= Quotient;
                    Zero_Flag <= '0';
                    Done <= '1';
                When One =>
                	Remainder <= "00000000";
                    Quotient <= unsigned(N);
                    Zero_Flag <= '0';
                    Done <= '1';
			end case;
        end if;
	end process;
    R <= std_logic_vector(Remainder);
    Q <= std_logic_vector(Quotient);
 end fsm;