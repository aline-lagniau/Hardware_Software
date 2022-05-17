library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ServoIn_TB is

		
end entity;

architecture TB of ServoIn_TB is


	component ServoIn is
		port(
			clk		: in std_logic;
			reset_n	: in std_logic;
			ena_in	: in std_logic;
			reg3_out	: out std_logic_vector(7 downto 0);
			reg4_out	: out std_logic_vector(7 downto 0);
			gpio_in	: in std_logic

		);
	end component;
	constant PERIOD : time := 20 ns;
	  
   signal clk: STD_LOGIC :='0';
	signal reset_n : std_logic := '0';
	signal sena_in : std_logic := '0';
	signal sreg3_out	: std_logic_vector(7 downto 0):= "00000000";
	signal sreg4_out : std_logic_vector(7 downto 0);
	signal sgpio_in : std_logic;
begin 
	
	uut: ServoIn
	port map (
		clk			=>clk,
		reset_n		=>reset_n,
		ena_in		=>sena_in,
		reg3_out		=>sreg3_out,
		reg4_out		=>sreg4_out,
		gpio_in		=>sgpio_in
	);



	reset_n_P: process -- crée le reset=1 pour démarrer le process
	begin
		reset_n <= '0';
		wait for PERIOD ;
		reset_n <= '1';
		wait;
	end process reset_n_P;
	
	clk_P: process --génère une clock qui alterne toutes les demi périodes
	begin
		clk <= '0';
		wait for PERIOD/2;
		clk <= '1';
		wait for PERIOD/2;
	end process clk_P;

	stimulus: process
	begin
		sgpio_in <= '0';
		if reset_n = '0' then
			wait until reset_n = '1';
		end if;
		
		for i in 0 to 2 loop
			sena_in <= '1';
			sgpio_in <= '1';
			wait for 1 ms; 
			sena_in <= '0';
			sgpio_in <= '0';
			wait for 20 ms - 1 ms;
		end loop;
		for i in 0 to 2 loop
			sena_in <= '1';
			sgpio_in <= '1';
			wait for 2 ms; 
			sena_in <= '0';
			sgpio_in <= '0';
			wait for 20 ms - 2 ms;
		end loop;
		
		for i in 0 to 2 loop	
			sena_in <= '1';
			sgpio_in <= '1';
			wait for (1 ms + (1 ms / 255)); 
			sena_in <= '0';
			sgpio_in <= '0';
			wait for 20 ms - 1 ms + 1 ms / 255;
		end loop;		
	end process;

end TB;
