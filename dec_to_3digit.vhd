library ieee;
use ieee.std_logic_1164;
use work.type_package.all;

entity dec_to_4digit is
	port (
		input: in sum;
		output: out digit_array
	);
end entity dec_to_4digit;

architecture rtl_synth_altera_convert3digit of dec_to_4digit is

begin
	comb_proc: process (input) is
	begin
		output(0) <= digit(integer(input) mod 10);
		output(1) <= digit((integer(input)/10) mod 10);
		output(2) <= digit(integer(input)/100 mod 10);
		output(3) <= digit(integer(input)/1000);
	end process comb_proc;
end;