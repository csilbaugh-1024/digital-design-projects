library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity N_comparator is
    port(
        A   : in STD_LOGIC_VECTOR(2 downto 0);
        B   : in STD_LOGIC_VECTOR(2 downto 0);
        Ngt : out STD_LOGIC
    );
end N_comparator;

architecture Behavioral of N_comparator is
begin
    Ngt <= '1' when unsigned(A) > unsigned(B) else
    '0';
end Behavioral;
