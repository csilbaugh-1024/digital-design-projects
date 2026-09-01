library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_full is
    port(
        W       : in STD_LOGIC_VECTOR(6 downto 0); -- Transmitter switches for ASCII letter
        send    : in STD_LOGIC; -- Transmitter send switch
        R       : in STD_LOGIC; -- Receiver input
        
        D       : out STD_LOGIC_VECTOR(6 downto 0); -- Receiver display
        C       : out STD_LOGIC; -- Transmitter output
        
        clk     : in STD_LOGIC
    );
end UART_full;

architecture Struct of UART_full is
begin

    Transmitter0    : entity work.Transmitter_7bit
        port map(
            W       => W,
            data_in => send,
            clk     => clk,
            y       => C
        );
        
    Receiver0       : entity work.Receiver_7bit
        port map(
            clk     => clk,
            y       => R,
            D       => D
        );
            
end Struct;
