library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Receiver_7bit is
    port(
        clk : in STD_LOGIC;
        y   : in STD_LOGIC;
        
        D   : out STD_LOGIC_VECTOR(6 downto 0)
    );
        
end Receiver_7bit;

architecture Struct of Receiver_7bit is

    signal ld_c         : STD_LOGIC;
    signal t_ld         : STD_LOGIC;
    signal N_sel        : STD_LOGIC;
    signal N_ld         : STD_LOGIC;
    signal Ngt6         : STD_LOGIC;

begin

    Datapath1   : entity work.Datapath_Receiver
        port map(
            ld_c        => ld_c,
            t_ld        => t_ld,
            N_sel       => N_sel,
            N_ld        => N_ld,
            y           => y,
            clk         => clk,
            Ngt6        => Ngt6,
            D           => D
        );
        
    Controller1 : entity work.Receiver_Controller
        port map(
            clk         => clk,
            y           => y,
            Ngt6        => Ngt6,
            ld_c        => ld_c,
            t_ld        => t_ld,
            N_sel       => N_sel,
            N_ld        => N_ld
        );

end Struct;
