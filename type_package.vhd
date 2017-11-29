library ieee;
use ieee.std_logic_1164.all;

package type_package is
	type digit is range 0 to 9;
	type number is range 0 to 999;
	type sum is range 0 to 1998;
	type digit_array is array (0 to 3) of digit;
	type integer_array is array (0 to  1) of integer;
	type digit_mem is array(1 downto 0) of digit_array;
	type digit_index is range 0 to 3;
	type state is (initial,load,save,show,add);
end package type_package;