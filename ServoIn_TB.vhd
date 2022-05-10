library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ServoIn_TB is

		
end entity;

architecture TB of ServoIn_TB is
   constant PERIOD : time := 20 ns;
   signal clk: STD_LOGIC :='0';
	signal rst_n : std_logic := '0';
	signal sena_in : std_logic := '0';
	signal sreg3_out	: std_logic_vector(7 downto 0): = "00000000";
	signal sreg4_out : std_logic_vector(7 downto 0);
	signal sgpioin : std_logic;

	component ServoIn is
		port 
		(
			clk		: in std_logic;
			rst_n	: in std_logic;
			ena_in	: in std_logic;
			reg3	: out std_logic_vector(7 downto 0);
			reg4	: out std_logic_vector(7 downto 0);
			gpioin	: in std_logic;

		);
	end component;
begin 
	
	dummy_in_I: dummy_in
	port map (
		clk			=>clk,
		rst_n		=>rst_n,
		ena_in		=>sena_in,
		reg3		=>sreg3_out,
		reg4		=>sreg4_out,
		sgpioin		=>sgpioin
	);



	rst_n_P: process
	begin
		rst_n <= '0';
		wait for PERIOD ;
		rst_n <= '1';
		wait;
	end process;
	clk_P process
	begin
		clk <= '0';
		wait for PERIOD/2;
		clk <= '1';
		wait for PERIOD/2;
	end process;

	stimulus: process
	begin
		sgpioin <= '0';
		if rst_n = '0' then
			wait until rst_n = '1';
		end if;
		for i in 0 to 10 loop	--on choisit n périodes pour avoir 1ms		
			sena_in <= '1';
			wait for 1 ms; --tester avec 2ms
			sena_in <= '0';
			wait for 20 ms - 1 ms; --tester avec 2ms
		end for;
		for i in 0 to 10 loop	--on choisit n périodes pour avoir 1ms				
			sena_in <= '1';
			wait for 2 ms; --tester avec 2ms
			sena_in <= '0';
			wait for 20 ms - 2 ms; --tester avec 2ms
		end for;
		for i in 0 to 10 loop	--on choisit n périodes pour avoir 1ms				
			sena_in <= '1';
			wait for (1 ms + (1 ms / 255)); --tester avec 2ms
			sena_in <= '0';
			wait for 20 ms - 1 ms + 1 ms / 255; --tester avec 2ms
		end for;		
	end progress;

end TB;
