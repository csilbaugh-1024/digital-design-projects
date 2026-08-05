library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2x1_3bit is
    port(
        A   : in STD_LOGIC_VECTOR(2 downto 0);
        B   : in STD_LOGIC_VECTOR(2 downto 0);
        sel : in STD_LOGIC;
        C   : out STD_LOGIC_VECTOR(2 downto 0)
        );
end Mux_2x1_3bit;

architecture Struct of Mux_2x1_3bit is
begin
    C <= B when sel = '1' else
    A;
end Struct;
