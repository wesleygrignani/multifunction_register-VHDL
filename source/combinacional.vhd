-- Design : logica combinacional 
-- Autor  : Wesley Grignani
-- Data   : 03/11/2020
-- Rev.   : 1.0


library ieee;
use ieee.std_logic_1164.all;

entity combinacional is
port ( i_SHL : in  std_logic;  -- Entrada shiftleft 
       i_LD  : in  std_logic;  -- Entrada Parallel Load
		 i_SET : in  std_logic;  -- Entrada Set
		 i_CLR : in  std_logic;  -- Entrada Clear
		 o_S   : out std_logic_vector(2 downto 0));
end combinacional;


architecture arch_1 of combinacional is 
begin

  o_S(2) <= (NOT i_CLR) AND i_SET;
  o_S(1) <= (i_CLR) OR ((NOT i_SET) AND (NOT i_LD) AND (i_SHL));
  o_S(0) <= (i_CLR) OR ((NOT i_SET) AND i_LD); 

end arch_1;