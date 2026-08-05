library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity comp_3bit is
    port(
        A   : in STD_LOGIC_VECTOR(2 downto 0);
        B   : in STD_LOGIC_VECTOR(2 downto 0);
        gt  : out STD_LOGIC
    );
end comp_3bit;

architecture Behavioral of comp_3bit is
begin
    gt <= '1' when unsigned(A) > unsigned(B) else
    '0';
end Behavioral;
