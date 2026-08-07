library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Baud_Gen is
    port(
        clk         : in STD_LOGIC;
        baud_tick   : out STD_LOGIC := '0'
    );
    
end Baud_Gen;

architecture Behavioral of Baud_Gen is

    signal count            : integer := 0;
    constant COUNT_THRESH   : integer := 10416; -- number ensures 9600 baud
    
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if count = COUNT_THRESH then
                count       <= 0;
                baud_tick   <= '1';
            else
                count       <= count + 1;
                baud_tick   <= '0';
            end if;
        end if;
    end process;
end Behavioral;
