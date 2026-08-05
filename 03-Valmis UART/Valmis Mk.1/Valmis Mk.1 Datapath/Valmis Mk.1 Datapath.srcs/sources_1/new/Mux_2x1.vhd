library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2x1 is
    port(
        A   : in STD_LOGIC;
        B   : in STD_LOGIC;
        sel : in STD_LOGIC;
        C   : out STD_LOGIC
        );
end Mux_2x1;

architecture Behavioral of Mux_2x1 is
begin
    C <= B when sel = '1' else
    A;
end Behavioral;
