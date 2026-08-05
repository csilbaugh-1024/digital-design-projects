library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift_Right_1 is
    port(
        A   : in STD_LOGIC_VECTOR(6 downto 0);
        B   : out STD_LOGIC_VECTOR(6 downto 0)
        );
end Shift_Right_1;

architecture Behavioral of Shift_Right_1 is
begin

    B(5 downto 0) <= A(6 downto 1);
    B(6) <= '1';

end Behavioral;
