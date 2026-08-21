library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2x1_N is
    port(
        A   : in STD_LOGIC_VECTOR(2 downto 0);
        B   : in STD_LOGIC_VECTOR(2 downto 0);
        sel : in STD_LOGIC;
        C   : out STD_LOGIC_VECTOR(2 downto 0)
    );
end Mux_2x1_N;

architecture Struct of Mux_2x1_N is
begin
    C <= A when sel = '0' else
    B;
end Struct;
