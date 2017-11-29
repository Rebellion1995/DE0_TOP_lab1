library ieee;
use ieee.std_logic_1164.all;

entity rising_edge_detector is
	port (
		input : in std_logic;
		clk : in std_logic;
		output : out std_logic
	);
end entity;

architecture rtl_synth_altera_detector of rising_edge_detector is
	signal ff1_reg,ff1_next:std_logic;
	signal ff2_reg,ff2_next:std_logic;
begin
	synch_proc: process (clk) is
	begin
		if(rising_edge(clk)) then
			ff1_reg<=ff1_next;
			ff2_reg<=ff2_next;
			end if;
	end process synch_proc;
	
	comb_proc: process(ff1_reg,ff2_reg,input) is
	begin
		ff1_next <= input;
		ff2_next <= ff1_reg;
		output <= ff1_reg and not ff2_reg;
	end process comb_proc;
end architecture rtl_synth_altera_detector;