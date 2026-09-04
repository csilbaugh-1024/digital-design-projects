library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_full is
    port(
        W       : in STD_LOGIC_VECTOR(6 downto 0); -- Transmitter switches for ASCII letter
        data_in : in STD_LOGIC; -- Transmitter send switch
        RX      : in STD_LOGIC; -- Receiver input
        
        D       : out STD_LOGIC_VECTOR(6 downto 0); -- Receiver display
        TX      : out STD_LOGIC; -- Transmitter output
        
        clk     : in STD_LOGIC
    );
end UART_full;

architecture Struct of UART_full is
begin

    Transmitter0    : entity work.Transmitter_7bit
        port map(
            W       => W,
            data_in => data_in,
            clk     => clk,
            y       => TX
        );
        
    Receiver0       : entity work.Receiver_7bit
        port map(
            clk     => clk,
            y       => RX,
            D       => D
        );
            
end Struct;
