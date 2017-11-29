library ieee;
use ieee.std_logic_1164.all;
use work.type_package.all;

entity LED_state_debug is
	port (
		input_state: in state;
		output_LED: out std_logic_vector(9 downto 0)
	);

end entity LED_state_debug;

architecture rtl_synth_altera_LED_debug of LED_state_debug is

begin
	comb_proc: process (input_state)
	begin
	output_LED <= "0000000000";
	case input_state is
		when initial =>
			output_LED(0) <= '1';
		when load =>
			output_LED(1) <= '1';
		when save =>
			output_LED(2) <= '1';
		when show =>
			output_LED(3) <= '1';
		when add =>
			output_LED(4) <= '1';
		when others =>
			output_LED(9) <= '1';
	end case;
	end process comb_proc;
end architecture rtl_synth_altera_LED_debug;