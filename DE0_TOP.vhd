----------------------------------------------------------------------
-- Copyright (c) 2009 by Terasic Technologies Inc. 
----------------------------------------------------------------------
--
-- Permission:
--
--   Terasic grants permission to use and modify this code for use
--   in synthesis for all Terasic Development Boards and Altera Development 
--   Kits made by Terasic.  Other use of this code, including the selling 
--   ,duplication, or modification of any portion is strictly prohibited.
--
-- Disclaimer:
--
--   This VHDL/Verilog or C/C++ source code is intended as a design reference
--   which illustrates how these types of functions can be implemented.
--   It is the user's responsibility to verify their design for
--   consistency and functionality through the use of formal
--   verification methods.  Terasic provides no warranty regarding the use 
--   or functionality of this code.
--
----------------------------------------------------------------------
--           
--                     Terasic Technologies Inc
--                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
--                     HsinChu County, Taiwan
--                     302
--
--                     web: http://www.terasic.com/
--                     email: support@terasic.com
--
----------------------------------------------------------------------
--
-- Major Functions:	DE0 TOP
--
----------------------------------------------------------------------
--
-- Revision History :
----------------------------------------------------------------------
--   Ver  :| Author            :| Mod. Date :| Changes Made:

----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.type_package.all;

entity DE0_TOP is
	port(
		----------------------  Clock Input  -------------------------
		CLOCK_50			: in std_logic;								--	50 MHz
		CLOCK_50_2		: in std_logic;								--	50 MHz
		----------------------  Push Button  -------------------------
		BUTTON			: in std_logic_vector(2 downto 0);		--	Pushbutton[2:0]
		----------------------  DPDT Switch  -------------------------
		SW					: in std_logic_vector(9 downto 0);		--	Toggle Switch[9:0]
		----------------------  7-SEG Dispaly  -----------------------
		HEX0_D			: out std_logic_vector(6 downto 0);		--	Seven Segment Digit 0
		HEX0_DP			: out std_logic;								--	Seven Segment Digit DP 0
		HEX1_D			: out std_logic_vector(6 downto 0);		--	Seven Segment Digit 1
		HEX1_DP			: out std_logic;								--	Seven Segment Digit DP 1
		HEX2_D			: out std_logic_vector(6 downto 0);		--	Seven Segment Digit 2
		HEX2_DP			: out std_logic;								--	Seven Segment Digit DP 2
		HEX3_D			: out std_logic_vector(6 downto 0);		--	Seven Segment Digit 3
		HEX3_DP			: out std_logic;								--	Seven Segment Digit DP 3
		----------------------  LED  ---------------------------------
		LEDG				: out std_logic_vector(9 downto 0);		--	LED Green[9:0]
		----------------------  UART  --------------------------------
		UART_TXD			: out std_logic;								--	UART Transmitter
		UART_RXD			: in std_logic;								--	UART Receiver
		UART_CTS			: out std_logic;								--	UART Clear To Send
		UART_RTS			: in std_logic;								--	UART Request To Send
		----------------------  SDRAM Interface  ---------------------
		DRAM_DQ			: inout std_logic_vector(15 downto 0);	--	SDRAM Data bus 16 Bits
		DRAM_ADDR		: out std_logic_vector(12 downto 0);	--	SDRAM Address bus 13 Bits
		DRAM_LDQM		: out std_logic;								--	SDRAM Low-byte Data Mask 
		DRAM_UDQM		: out std_logic;								--	SDRAM High-byte Data Mask
		DRAM_WE_N		: out std_logic;								--	SDRAM Write Enable
		DRAM_CAS_N		: out std_logic;								--	SDRAM Column Address Strobe
		DRAM_RAS_N		: out std_logic;								--	SDRAM Row Address Strobe
		DRAM_CS_N		: out std_logic;								--	SDRAM Chip Select
		DRAM_BA_0		: out std_logic;								--	SDRAM Bank Address 0
		DRAM_BA_1		: out std_logic;								--	SDRAM Bank Address 1
		DRAM_CLK			: out std_logic;								--	SDRAM Clock
		DRAM_CKE			: out std_logic;								--	SDRAM Clock Enable
		----------------------  Flash Interface  ---------------------
		FL_DQ				: inout std_logic_vector(14 downto 0);	--	FLASH Data bus 15 Bits
		FL_DQ15_AM1		: inout std_logic;							--	FLASH Data bus Bit 15 or Address A-1
		FL_ADDR			: out std_logic_vector(21 downto 0);	--	FLASH Address bus 22 Bits
		FL_WE_N			: out std_logic;								--	FLASH Write Enable
		FL_RST_N			: out std_logic;								--	FLASH Reset
		FL_OE_N			: out std_logic;								--	FLASH Output Enable
		FL_CE_N			: out std_logic;								--	FLASH Chip Enable
		FL_WP_N			: out std_logic;								--	FLASH Hardware Write Protect
		FL_BYTE_N		: out std_logic;								--	FLASH Selects 8/16-bit mode
		FL_RY				: in std_logic;								--	FLASH Ready/Busy
		----------------------  LCD Module 16X2  ---------------------
		LCD_DATA			: inout std_logic_vector(7 downto 0);	--	LCD Data bus 8 bits
		LCD_BLON			: out std_logic;								--	LCD Back Light ON/OFF
		LCD_RW			: out std_logic;								--	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN			: out std_logic;								--	LCD Enable
		LCD_RS			: out std_logic;								--	LCD Command/Data Select, 0 = Command, 1 = Data
		----------------------  SD_Card Interface  -------------------
		SD_DAT0			: inout std_logic;							--	SD Card Data 0
		SD_DAT3			: inout std_logic;							--	SD Card Data 3
		SD_CMD			: inout std_logic;							--	SD Card Command Signal
		SD_CLK			: out std_logic;								--	SD Card Clock
		SD_WP_N			: in std_logic;								--	SD Card Write Protect
		----------------------  PS2  ---------------------------------
		PS2_KBDAT		: inout std_logic;							--	PS2 Keyboard Data
		PS2_KBCLK		: inout std_logic;							--	PS2 Keyboard Clock
		PS2_MSDAT		: inout std_logic;							--	PS2 Mouse Data
		PS2_MSCLK		: inout std_logic;							--	PS2 Mouse Clock
		----------------------  VGA  ---------------------------------
		VGA_HS			: out std_logic;								--	VGA H_SYNC
		VGA_VS			: out std_logic;								--	VGA V_SYNC
		VGA_R				: out std_logic_vector(3 downto 0);		--	VGA Red[3:0]
		VGA_G				: out std_logic_vector(3 downto 0);		--	VGA Green[3:0]
		VGA_B				: out std_logic_vector(3 downto 0);		--	VGA Blue[3:0]
		----------------------  GPIO  --------------------------------
		GPIO0_CLKIN		: in std_logic_vector(1 downto 0);		--	GPIO Connection 0 Clock In Bus
		GPIO0_CLKOUT	: out std_logic_vector(1 downto 0);		--	GPIO Connection 0 Clock Out Bus
		GPIO0_D			: inout std_logic_vector(31 downto 0);	--	GPIO Connection 0 Data Bus
		GPIO1_CLKIN		: in std_logic_vector(1 downto 0);		--	GPIO Connection 1 Clock In Bus
		GPIO1_CLKOUT	: out std_logic_vector(1 downto 0);		--	GPIO Connection 1 Clock Out Bus
		GPIO1_D			: inout std_logic_vector(31 downto 0)	--	GPIO Connection 1 Data Bus
	);
end entity DE0_TOP;

architecture rtl of DE0_TOP is

	signal button_pressed: std_logic_vector(2 downto 0);

	
	signal state_reg, state_next: state := initial;
	
	signal display_reg, display_next: digit_array:= (others => 0);
	signal counter_reg, counter_next: digit_array:= (others => 0);
	signal enable_reg, enable_next: std_logic := '1';
	signal digit_reg, digit_next: integer:=0;
	
	type rotate_counter_type is range 0 to 499_999_999;
	signal rotate_counter_reg, rotate_counter_next : rotate_counter_type;
	
	signal number_reg, number_next: digit_mem;
	signal index_reg, index_next: integer:=0;
	signal add_reg, add_next : sum:=0;
	signal dec0,dec1: sum:=0;
	signal sum_reg, sum_next : digit_array:=(others=>0);
	
begin
	synch_proc: process (CLOCK_50) is
	begin
		if(rising_edge(CLOCK_50)) then
			state_reg <= state_next;
			-- DIGIT COUNTERS
			counter_reg(0) <= counter_next(0);
			counter_reg(1) <= counter_next(1);
			counter_reg(2) <= counter_next(2);
			counter_reg(3) <= counter_next(3);
			-- DISPLAY REGISTERS
			display_reg(0) <= display_next(0);
			display_reg(1) <= display_next(1);
			display_reg(2) <= display_next(2);
			display_reg(3) <= display_next(3);
			-- NUMBER MEMORY
			number_reg(0) <= number_next(0);
			number_reg(1) <= number_next(1);
			-- NUMBER MEMORY INDEX
			index_reg <= index_next;
			-- DISPLAY ENABLE REG
			enable_reg <= enable_next;
			-- DIGIT COUNTER INDEX
			digit_reg <= digit_next;
			-- TIME COUNTER
			rotate_counter_reg<=rotate_counter_next;
			--	ADD REG
			add_reg <= add_next;
			--sum_reg <= sum_next;
		end if;
	end process synch_proc;
	
	add_proc: process (number_reg, dec0,dec1) is
	begin
		add_next <= dec0 + dec1;
	end process add_proc;
	
	state_machine: process (state_reg,counter_reg,button_pressed,enable_reg, number_reg,index_reg,rotate_counter_reg,digit_reg,display_reg,SW,button_pressed) is
	begin
		
		state_next <= state_reg;
		counter_next(0) <= counter_reg(0);
		counter_next(1) <= counter_reg(1);
		counter_next(2) <= counter_reg(2);
		counter_next(3) <= counter_reg(3);
		display_next(0) <= display_reg(0);
		display_next(1) <= display_reg(1);
		display_next(2) <= display_reg(2);
		display_next(3) <= display_reg(3);
		number_next(0) <= number_reg(0);
		number_next(1) <= number_reg(1);
		enable_next <= enable_reg;
		index_next <= index_reg;
		digit_next <= digit_reg;
		rotate_counter_next <= rotate_counter_reg;
		counter_next <= counter_reg;
		display_next <= display_reg;
		
		if	(button_pressed(2) = '1') then 		-- RESET
			state_next <= initial;
		else
		case state_reg is
			when initial => 
				digit_next <= 0;
				counter_next(0) <= 0;
				counter_next(1) <= 0;
				counter_next(2) <= 0;
				--enable_next <= '0';
				
				if(SW(2)='1') then 		-- ADD
					state_next <= add;
				elsif(SW(1)='1') then 	-- SHOW
					state_next <= show;
				elsif(SW(0)='1') then 	-- LOAD
					state_next <= load;
				end if;
				
			when load =>
				display_next(0) <= counter_reg(0);
				display_next(1) <= counter_reg(1);
				display_next(2) <= counter_reg(2);
				display_next(3) <= 0;
				enable_next <= '1';
				if(SW(2)='1' or SW(0)='0' or SW(1)='1') then 		
					state_next <= save;
				elsif(button_pressed(1) = '1') then
					if(digit_reg < 2) then
						digit_next <= digit_reg + 1;
					end if;
				elsif (button_pressed(0) = '1') then
					if(counter_reg(digit_reg)<9) then
						counter_next(digit_reg) <= counter_reg(digit_reg) + 1;
					end if;
				end if;
			
			when save =>
				number_next(index_reg)<=counter_reg;
				index_next <= 1 - index_reg;
				state_next <= initial;
				
			when show => 
				display_next <= number_reg(index_reg);
				if (SW(1)='0' or SW(2)='1') then
					rotate_counter_next <= 0;
					state_next <= initial;
				else
					if(rotate_counter_reg=49_999_999) then
						enable_next <= '0';
						rotate_counter_next <= rotate_counter_reg + 1;
					elsif(rotate_counter_reg=74_999_999) then
						enable_next <= '1';
						index_next <= 1 - index_reg;
						rotate_counter_next <= 0;
					else
						enable_next <= '1';
						display_next <= number_reg(index_reg);
						rotate_counter_next <= rotate_counter_reg + 1;
					end if;
				end if;
				
				
			when add => 
				display_next <= sum_reg;
				enable_next <= '1';
				if(SW(2)='0') then
					state_next <= show;
				end if;
			
		end case;
		end if;
	end process state_machine;
	
	generate_buttons: for i in 2 downto 0 generate
	inst_button_detector: entity work.rising_edge_detector(rtl_synth_altera_detector)
		port map(
			input => not BUTTON(i),
			clk => CLOCK_50,
			output => button_pressed(i)
		);
		
	end generate;
	
	HEX0_DP <= '1';
	HEX1_DP <= '1';
	HEX2_DP <= '1';
	HEX3_DP <= '1';
	
	inst_hex0_converter: entity work.bin_to_7seg(rtl_synth_altera_converter)
		port map(
			input => display_reg(0),
			enable => enable_reg,
			output => HEX0_D
		);
		
	inst_hex1_converter: entity work.bin_to_7seg(rtl_synth_altera_converter)
		port map(
			input => display_reg(1),
			enable => enable_reg,
			output => HEX1_D
		);
		
	inst_hex2_converter: entity work.bin_to_7seg(rtl_synth_altera_converter)
		port map(
			input => display_reg(2),
			enable => enable_reg,
			output => HEX2_D
		);
		
	inst_hex3_converter: entity work.bin_to_7seg(rtl_synth_altera_converter)
		port map(
			input => display_reg(3),
			enable => enable_reg,
			output => HEX3_D
		);
		
	inst_dec0_converter: entity work.digit3_to_dec(rtl_synth_altera_convertdec)
		port map(
			input => number_reg(0),
			output => dec0
		);
		
	inst_dec1_converter: entity work.digit3_to_dec(rtl_synth_altera_convertdec)
		port map(
			input => number_reg(1),
			output => dec1
		);
	
	inst_digit1_converter: entity work.dec_to_4digit(rtl_synth_altera_convert3digit)
		port map(
			input => add_reg,
			output => sum_reg
		);
		
	inst_LED_debugger: entity work.LED_state_debug(rtl_synth_altera_LED_debug)
		port map(
			input_state=>state_reg,
			output_LED=>LEDG
		);
		
end architecture rtl;