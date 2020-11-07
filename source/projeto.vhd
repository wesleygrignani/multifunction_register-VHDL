-- Design : projeto 
-- Autor  : Wesley Grignani
-- Data   : 03/11/2020
-- Rev.   : 1.0

library ieee;
use ieee.std_logic_1164.all;

entity projeto is 
port ( i_SHL    : in  std_logic;  -- entrada shiftleft 
       i_LD     : in  std_logic;  -- entrada parallel load
		 i_SET    : in  std_logic;  -- entrada set
		 i_CLR    : in  std_logic;  -- entrada clear 
		 i_SHL_IN : in  std_logic;  -- entrada bit shift left
		 i_CLK    : in  std_logic;  -- clock
		 i_I      : in  std_logic_vector(7 downto 0);  -- entrada de dados 
		 o_Q      : out std_logic_vector(7 downto 0)); -- saida de dados 
end projeto;


architecture arch_1 of projeto is

-- Bloco de logica combinacional 
component combinacional is
port ( i_SHL : in  std_logic;  -- Entrada shiftleft 
       i_LD  : in  std_logic;  -- Entrada Parallel Load
		 i_SET : in  std_logic;  -- Entrada Set
		 i_CLR : in  std_logic;  -- Entrada Clear
		 o_S   : out std_logic_vector(2 downto 0));
end component;

-- Registrador multifunção
component registrador is
port ( i_SHL_IN : in  std_logic;
		 i_CLK    : in  std_logic;
		 i_I      : in  std_logic_vector(7 downto 0);
		 i_S      : in  std_logic_vector(2 downto 0);
		 o_Q      : out std_logic_vector(7 downto 0));
end component;

signal w_S : std_logic_vector(2 downto 0);

begin

-- instanciando o bloco combinacional 
  u_0 : combinacional
    port map ( i_SHL => i_SHL,
	            i_LD  => i_LD,
					i_SET => i_SET,
					i_CLR => i_CLR,
					o_S   => w_S);
					
-- instanciando o registrador
  u_1 : registrador
    port map ( i_SHL_IN => i_SHL_IN,
	            i_CLK    => i_CLK,
					i_I      => i_I,
					i_S      => w_S,
					o_Q      => o_Q);

					
end arch_1;