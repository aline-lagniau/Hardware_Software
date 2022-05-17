library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;



entity ServoIn is
	port (
		
			clk		: in std_logic;
			reset_n	: in std_logic;
			ena_in	: in std_logic;
			reg3_out		: out std_logic_vector(7 downto 0);
			reg4_out		: out std_logic_vector(7 downto 0);
			gpio_in	: in std_logic
			
		);
		
end entity;

architecture RTL of ServoIn is
     type state_type is (s0,s1,s2,s3);
	  signal state : state_type;
	 
	 
begin 
	process (clk,reset_n,ena_in,gpio_in)
		variable count : natural :=0;
		constant k : natural :=50000000;
		constant min : natural :=50000;
		constant b : natural :=255;
		--constant invm : real := 0.00002;
	begin
		if reset_n = '0' then
			count :=0;
			state <= s0;
		elsif rising_edge(clk) then
			case state is
				when s0 =>
					count :=0; -- incrémenter deja à s0 si ok
					if ena_in = '1' then
						if gpio_in='1'then
							state <= s1;
						end if;
				end if;
				when s1 =>
					count := count + 1;
						if gpio_in='0'then
							reg3_out <= std_logic_vector(to_unsigned((count-min)*b/min,8)); --changer
							state <= s2;
						end if;
				when s2 =>
				count := count + 1;
						if gpio_in='1'then
							reg4_out <= std_logic_vector(to_unsigned((k/count),8)); --sortir fréquence en fct de clk, pas bon
							count :=0;
							if ena_in = '1' then
								state <=s1;
							else
								state <= s0;
							end if;
						end if;
						when others =>
					count :=0;
					state <= s0;
			end case;
		end if;
	end process;
					
end RTL;
