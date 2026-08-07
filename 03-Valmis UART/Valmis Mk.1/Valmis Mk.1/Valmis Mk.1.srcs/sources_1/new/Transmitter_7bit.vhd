library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Transmitter_7bit is

    port(
        clk         : in STD_LOGIC;
        W           : in STD_LOGIC_VECTOR(6 downto 0);
        data_in     : in STD_LOGIC;
        y           : out STD_LOGIC
    );
        
end Transmitter_7bit;

architecture Struct of Transmitter_7bit is

    signal Igt6         : STD_LOGIC;
    
    signal I_sel        : STD_LOGIC;
    signal W_sel        : STD_LOGIC;
    signal I_ld         : STD_LOGIC;
    signal W_ld         : STD_LOGIC;
    signal y_sel        : STD_LOGIC;
    signal y_ld         : STD_LOGIC;
    signal p1NOT        : STD_LOGIC;
    
    signal baud_tick    : STD_LOGIC;
    
begin

    Datapath0   : entity work.Datapath
        port map(
            I_sel       => I_sel,
            W_sel       => W_sel,
            I_ld        => I_ld,
            W_ld        => W_ld,
            y_sel       => y_sel,
            y_ld        => y_ld,
            p1NOT       => p1NOT,
            W           => W,
            clk         => clk,
            
            Igt6        => Igt6,
            y           => y
        );
        
    Controller0 : entity work.Controller
        port map(
            data_in     => data_in,
            Igt6        => Igt6,
            clk         => clk,
            baud_tick   => baud_tick,
            
            I_sel       => I_sel,
            W_sel       => W_sel,
            I_ld        => I_ld,
            W_ld        => W_ld,
            y_sel       => y_sel,
            y_ld        => y_ld,
            p1NOT       => p1NOT
        );
        
    Baud_Gen0   : entity work.Baud_Gen
        port map(
            clk         => clk,
            baud_tick   => baud_tick
        );

end Struct;
