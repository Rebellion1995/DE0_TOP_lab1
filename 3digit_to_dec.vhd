library ieee;
use ieee.std_logic_1164.all;
use work.type_package.all;

entity digit3_to_dec is
	port(
		input : in digit_array;
		output: out sum
	);
end entity digit3_to_dec;

architecture rtl_synth_altera_convertdec of digit3_to_dec is

begin
	comb_proc: process (input) is
	begin
		output <= sum(integer(input(0)) + integer(input(1))*10 + integer(input(2))*100);
	end process comb_proc;
end architecture rtl_synth_altera_convertdec;