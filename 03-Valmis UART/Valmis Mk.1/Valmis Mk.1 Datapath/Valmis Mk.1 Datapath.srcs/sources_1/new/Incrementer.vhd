library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Incrementer is
    port(
        A   : in STD_LOGIC_VECTOR(2 downto 0);
        B   : out STD_LOGIC_VECTOR(2 downto 0)
    );
end Incrementer;

architecture Behavioral of Incrementer is
begin

    B  <= STD_LOGIC_VECTOR(unsigned(A)+1);

end Behavioral;
