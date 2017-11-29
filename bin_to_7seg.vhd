library ieee;
use ieee.std_logic_1164.all;
use work.type_package.all;
entity bin_to_7seg is
	port(
		input: in digit;
		enable: in std_logic;
		output: out std_logic_vector(6 downto 0)
	);
end entity bin_to_7seg;


architecture rtl_synth_altera_converter of bin_to_7seg is

begin
comb_proc: process (input,enable) is
begin
	if (enable='1') then
		case input is
			when 0 =>
				output <= "1000000";
			when 1 =>
				output <= "1111001";
			when 2 =>
				output <= "0100100";
			when 3 =>
				output <= "0110000";
			when 4 =>
				output <= "0011001";
			when 5 =>
				output <= "0010010";
			when 6 =>
				output <= "0000010";
			when 7 =>
				output <= "1111000";
			when 8 =>
				output <= "0000000";
			when 9 =>
				output <= "0010000";
			when others =>
				output <= "0011111";
		end case;
	else
		output <= "0111111";
	end if;
	end process comb_proc;
end architecture rtl_synth_altera_converter;