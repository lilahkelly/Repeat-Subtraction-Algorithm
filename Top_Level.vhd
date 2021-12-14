library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Divider is
port (start: in std_logic;
	clk, reset: in std_logic;
    N, D: in std_logic_vector(7 downto 0);
    Q, R: out std_logic_vector(7 downto 0);
    Zero_flag, done: out std_logic);
end Divider;

architecture structural of Divider is

component Project_datapath is
port (N, D: in std_logic_vector(7 downto 0);
	clk, reset: in std_logic;
    Q_ld, Q_sel, R_ld, R_sel: in std_logic;
    Q, R: out std_logic_vector(7 downto 0);
    D_eq_1, R_lt_D, Zero_Flag: out std_logic);
end component;

component Project_Control is
port 	(start, D_eq_1, R_lt_D, Zero_Flag:in std_logic;
		clk, reset: in std_logic;
        done, Q_ld, Q_sel, R_ld, R_sel: out std_logic);
end component;

signal D_eq_1, R_lt_D, Q_ld, Q_sel, R_ld, R_sel, Zero:std_logic;

begin
control: Project_Control port map(start, D_eq_1, R_lt_D, Zero, clk, reset, done, Q_ld, Q_sel, R_ld, R_sel);
datapath: Project_datapath port map(N, D, clk, reset, Q_ld, Q_sel, R_ld, R_sel, Q, R, D_eq_1, R_lt_D, Zero);
Zero_Flag <= Zero;
end structural;