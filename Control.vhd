library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Project_Control is
port 	(start, D_eq_1, R_lt_D, Zero_Flag:in std_logic;
		clk, reset: in std_logic;
        done, Q_ld, Q_sel, R_ld, R_sel: out std_logic);
end Project_Control;

architecture fsm of Project_Control is

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
                    elsif (Zero_Flag = '1') then
                    	Ex_state := Zero;
                    elsif (D_eq_1 = '1') then
                    	Ex_state := One;
                    elsif (R_lt_D = '1') then
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
                	if (R_lt_D = '1') then
                    	Ex_state := Fin2;
                    else
                    	Ex_state := Divide;
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
                	done <= '0';
                    Q_ld <= '1';
                    Q_sel <= '0';
                    R_ld <= '1';
                    R_sel <= '0';
                when Divide =>
                	done <= '0';
                    Q_ld <= '1';
                    Q_sel <= '1';
                    R_ld <= '1';
                    R_sel <= '1';
                when Zero =>
                	done <= '1';
                    Q_ld <= '0';
                    Q_sel <= '0';
                    R_ld <= '0';
                    R_sel <= '0';
                when Fin1 =>
                	done <= '1';
                    Q_ld <= '0';
                    Q_sel <= '0';
                    R_ld <= '0';
                    R_sel <= '0';
                when Fin2 =>
                	done <= '1';
                    Q_ld <= '0';
                    Q_sel <= '0';
                    R_ld <= '0';
                    R_sel <= '0';
                when One =>
                	done <= '1';
                    Q_ld <= '0';
                    Q_sel <= '0';
                    R_ld <= '0';
                    R_sel <= '0';
                end case;
            end if;
      end process;
end fsm;