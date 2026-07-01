library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    port(
        A   : in STD_LOGIC_VECTOR(3 downto 0);
        B   : in STD_LOGIC_VECTOR(3 downto 0);
        s2  : in STD_LOGIC;
        s1  : in STD_LOGIC;
        s0  : in STD_LOGIC;
        C   : out STD_LOGIC_VECTOR(3 downto 0);
    );
end ALU;
