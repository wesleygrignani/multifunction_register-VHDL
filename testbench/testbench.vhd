-- Design : testbench projeto 
-- Autor  : Wesley Grignani
-- Data   : 03/11/2020
-- Rev.   : 1.0


library ieee;
use ieee.std_logic_1164.all;

entity testbench is
-- vazio
end testbench;


architecture arch_1 of testbench is

-- DUT 
component projeto is 
port ( i_SHL    : in  std_logic;  -- entrada shiftleft 
       i_LD     : in  std_logic;  -- entrada parallel load
		 i_SET    : in  std_logic;  -- entrada set
		 i_CLR    : in  std_logic;  -- entrada clear 
		 i_SHL_IN : in  std_logic;  -- entrada bit shift left
		 i_CLK    : in  std_logic;  -- clock
		 i_I      : in  std_logic_vector(7 downto 0);  -- entrada de dados 
		 o_Q      : out std_logic_vector(7 downto 0)); -- saida de dados 
end component;

signal w_i_SHL, w_i_LD, w_i_SET, w_i_CLR, w_i_SHL_IN, w_i_CLK : std_logic;  
signal w_i_I, w_o_Q : std_logic_vector(7 downto 0);
constant c_CLK_PERIOD : time := 1 ns;

begin 

-- Conexao DUT
  u_DUV: projeto port map ( i_SHL    => w_i_SHL,
                            i_LD     => w_i_LD,
									 i_SET    => w_i_SET,
									 i_CLR    => w_i_CLR,
									 i_SHL_IN => w_i_SHL_IN,
									 i_CLK    => w_i_CLK,
									 i_I      => w_i_I,
									 o_Q      => w_o_Q);
									 
-- Processo para o clock									 
  p_CLK: process
  begin
  	w_i_CLK <= '0';
    wait for c_CLK_PERIOD/2;  
    w_i_CLK <= '1';
    wait for c_CLK_PERIOD/2;  
  end process p_CLK;
  
  p_INPUTS: process
    begin
	 -- ativando o clear do circuito
	 w_i_CLR    <= '1';
	 w_i_SHL    <= '0';
	 w_i_LD     <= '0';
	 w_i_SET    <= '0';
	 w_i_SHL_IN <= '0';
	  
	 -- entrada zerada
	 w_i_I <= "00000000";
	  
	 -- borda de subida do clock
	 wait for c_CLK_PERIOD;
	 assert(w_o_Q = "00000000") report "fail @1" severity error;
	  
	  
	 -- Setando todos os bits da saida para 1
	 w_i_SHL    <= '0';
	 w_i_LD     <= '0';
	 w_i_SET    <= '1';
    w_i_CLR    <= '0';
	 w_i_SHL_IN <= '0';
	  
	 -- borda de subida do clock
	 wait for c_CLK_PERIOD;
	 assert(w_o_Q = "11111111") report "fail @2" severity error;
	  
	  
	 -- Parallel load
	 w_i_SHL    <= '0';
	 w_i_LD     <= '1';
	 w_i_SET    <= '0';
	 w_i_CLR    <= '0';
	 w_i_SHL_IN <= '0';
	  
	 -- borda de subida do clock
	 wait for c_CLK_PERIOD;
	 assert(w_o_Q = "00000000") report "fail @2" severity error;
	  
	  
	 -- Ativando o shift left com bit 0
	 w_i_SHL    <= '1';
	 w_i_LD     <= '0';
	 w_i_SET    <= '0';
	 w_i_CLR    <= '0';
	 w_i_SHL_IN <= '1';
	  
	 -- aguardando 2 borda de subida do clock
	 wait for c_CLK_PERIOD;
	 wait for c_CLK_PERIOD;
	 assert(w_o_Q = "00000011") report "fail @2" severity error;
	  
	  
	 -- mantendo o valor presente da saida
	 w_i_SHL    <= '0';
	 w_i_LD     <= '0';
	 w_i_SET    <= '0';
	 w_i_CLR    <= '0';
	 w_i_SHL_IN <= '0';
	  
	 -- borda de subida do clock
	 wait for c_CLK_PERIOD;
	 assert(w_o_Q = "00000011") report "fail @2" severity error;
	  
	  
	 -- zerando as entradas
	 w_i_SHL    <= '0';
	 w_i_LD     <= '0';
	 w_i_SET    <= '0';
	 w_i_CLR    <= '0';
	 w_i_SHL_IN <= '0';
	 w_i_I      <= "00000000";
	 assert false report "Test done." severity note;
	 wait;
  end process;
end arch_1;