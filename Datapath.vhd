library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Project_datapath is
port (N, D: in std_logic_vector(7 downto 0);
	clk, reset: in std_logic;
    Q_ld, Q_sel, R_ld, R_sel: in std_logic;
    Q, R: out std_logic_vector(7 downto 0);
    D_eq_1, R_lt_D, Zero_Flag: out std_logic);
end Project_datapath;

architecture structural of Project_datapath is

component compare_8bit is
port (A, B: in std_logic_vector(7 downto 0);
      lt, eq, gt: out std_logic);
end component;

component subtractor_8Bit is
port (A, B : in std_logic_vector(7 downto 0);
	S: out std_logic_vector(7 downto 0));
end component;

component incrementor8bit is
port (A : in std_logic_vector(7 downto 0);
      S: out std_logic_vector(7 downto 0));
end component;

component Mux2x1 is
port(Sel:in std_logic;
     D0, D1:in std_logic_vector(7 downto 0);
	 F: out std_logic_vector(7 downto 0));
end component;

component reg8bit is
port (D : in std_logic_vector(7 downto 0);
      clk, reset, ld: in std_logic;
      Q: out std_logic_vector(7 downto 0));
end component;


signal R_sub, R_Muxed, R_out, Q_Muxed, Q_out, Q_inc: std_logic_vector(7 downto 0);
signal R_gt_D, R_eq_D, D_lt_1, D_gt_1, D_lt_0, D_gt_0: std_logic;
begin
R_Mux: Mux2x1 port map(R_sel, N, R_Sub, R_Muxed);
R_reg: reg8bit port map(R_Muxed, clk, reset, R_ld, R_out);
R_subtract: subtractor_8Bit port map(R_out, D, R_Sub);
R_Compare_D: compare_8bit port map(R_muxed, D, R_lt_D, R_eq_D, R_gt_D);
D_Compare_1: compare_8bit port map(D, "00000001", D_lt_1, D_eq_1, D_gt_1);
D_compare_0: compare_8bit port map(D, "00000000", D_lt_0, Zero_Flag, D_gt_0); 
Q_Mux: Mux2x1 port map(Q_sel, "00000000", Q_inc, Q_Muxed);
Q_reg: reg8bit port map(Q_Muxed, clk, reset, Q_ld, Q_out);
Q_increment: incrementor8bit port map(Q_out, Q_inc);

R <= R_out;
Q <= Q_out;
end structural;