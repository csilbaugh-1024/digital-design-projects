library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity four_bit_2x1_mux is
    port(
        A   : in STD_LOGIC_VECTOR(3 downto 0);
        B   : in STD_LOGIC_VECTOR(3 downto 0);
        sel : in STD_LOGIC;
        C   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end four_bit_2x1_mux;
    
architecture behavioral of four_bit_2x1_mux is
begin
    C   <= A when (sel='1') else B;
end behavioral;