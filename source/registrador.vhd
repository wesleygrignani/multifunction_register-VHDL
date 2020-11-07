-- Design : registrador multifunção 
-- Autor  : Wesley Grignani
-- Data   : 03/11/2020
-- Rev.   : 1.0


library ieee;
use ieee.std_logic_1164.all;

entity registrador is
port ( i_SHL_IN : in  std_logic;
		 i_CLK    : in  std_logic;
		 i_I      : in  std_logic_vector(7 downto 0);
		 i_S      : in  std_logic_vector(2 downto 0);
		 o_Q      : out std_logic_vector(7 downto 0));
end registrador;


architecture arch_1 of registrador is 
signal w_Q : std_logic_vector(7 downto 0); -- sinal auxiliar
begin 
  process(i_CLK)
  begin
    if(rising_edge(i_CLK)) then 
	   if(i_S = "000") then     -- present value
		  w_Q <= w_Q;
		elsif(i_S = "010") then  -- shift left
		  w_Q(0) <= i_SHL_IN;
		  w_Q(7 downto 1) <= w_Q(6 downto 0);
		elsif(i_S = "001") then  -- parallel load
		  w_Q <= i_I;
      elsif(i_S = "100") then  -- set to all 1s
		  w_Q <= "11111111";
      elsif(i_S = "011") then  -- clear to all 0s
		  w_Q <= "00000000";
		else
		  w_Q <= "00000000";     -- others 
		end if;
    end if;
  end process;
  o_Q <= w_Q;
end arch_1;