library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity N_Incrementer is
    port(
        A   : in STD_LOGIC_VECTOR(2 downto 0);
        B   : out STD_LOGIC_VECTOR(2 downto 0)
    );
end N_Incrementer;

architecture Behavioral of N_Incrementer is
begin
    B <= STD_LOGIC_VECTOR(unsigned(A)+1);
end Behavioral;
