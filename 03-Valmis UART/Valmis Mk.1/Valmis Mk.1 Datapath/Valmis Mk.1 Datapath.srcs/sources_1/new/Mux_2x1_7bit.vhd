library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2x1_7bit is
    port(
        A   : in STD_LOGIC_VECTOR(6 downto 0);
        B   : in STD_LOGIC_VECTOR(6 downto 0);
        sel : in STD_LOGIC;
        C   : out STD_LOGIC_VECTOR(6 downto 0)
        );
end Mux_2x1_7bit;

architecture Behavioral of Mux_2x1_7bit is
begin
    C <= B when sel = '1' else
    A;
end Behavioral;
