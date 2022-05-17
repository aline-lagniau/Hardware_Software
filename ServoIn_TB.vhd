library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ServoIn_TB is

		
end entity;

architecture TB of ServoIn_TB is


	component ServoIn is
		port(
			clk		: in std_logic;
			rst_n	: in std_logic;
			ena_in	: in std_logic;
			reg3	: out std_logic_vector(7 downto 0);
			reg4	: out std_logic_vector(7 downto 0);
			gpioin	: in std_logic

		);
	end component;
	constant PERIOD : time := 20 ns;
	  
   signal clk: STD_LOGIC :='0';
	signal rst_n : std_logic := '0';
	signal sena_in : std_logic := '0';
	signal sreg3	: std_logic_vector(7 downto 0):= "00000000";
	signal sreg4 : std_logic_vector(7 downto 0);
	signal sgpioin : std_logic;
begin 
	
	uut: ServoIn
	port map (
		clk			=>clk,
		rst_n		=>rst_n,
		ena_in		=>sena_in,
		reg3		=>sreg3,
		reg4		=>sreg4,
		gpioin		=>sgpioin
	);



	rst_n_P: process -- crée le reset=1 pour démarrer le process
	begin
		rst_n <= '0';
		wait for PERIOD ;
		rst_n <= '1';
		wait;
	end process rst_n_P;
	
	clk_P: process --génère une clock qui alterne toutes les demi périodes
	begin
		clk <= '0';
		wait for PERIOD/2;
		clk <= '1';
		wait for PERIOD/2;
	end process clk_P;

	stimulus: process
	begin
		sgpioin <= '0';
		if rst_n = '0' then
			wait until rst_n = '1';
		end if;
		
		for i in 0 to 2 loop
			sena_in <= '1';
			sgpioin <= '1';
			wait for 1 ms; 
			sena_in <= '0';
			sgpioin <= '0';
			wait for 20 ms - 1 ms;
		end loop;
		for i in 0 to 2 loop
			sena_in <= '1';
			sgpioin <= '1';
			wait for 2 ms; 
			sena_in <= '0';
			sgpioin <= '0';
			wait for 20 ms - 2 ms;
		end loop;
		
		for i in 0 to 2 loop	
			sena_in <= '1';
			sgpioin <= '1';
			wait for (1 ms + (1 ms / 255)); 
			sena_in <= '0';
			sgpioin <= '0';
			wait for 20 ms - 1 ms + 1 ms / 255;
		end loop;		
	end process;

end TB;
