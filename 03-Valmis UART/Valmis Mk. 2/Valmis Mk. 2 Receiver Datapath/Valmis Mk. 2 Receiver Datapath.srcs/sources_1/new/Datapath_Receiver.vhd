library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath_Receiver is
    port(
        ld_c        : in STD_LOGIC;
        t_ld        : in STD_LOGIC;
        N_sel       : in STD_LOGIC;
        N_ld        : in STD_LOGIC;
        baud_tick   : in STD_LOGIC;
        y           : in STD_LOGIC;
        
        D           : out STD_LOGIC_VECTOR(6 downto 0)
    );
end Datapath_Receiver;

architecture Behavioral of Datapath_Receiver is

    signal N_mux    : STD_LOGIC_VECTOR(2 downto 0);
    signal N_reg    : STD_LOGIC_VECTOR(2 downto 0);
    signal N_inc    : STD_LOGIC_VECTOR(2 downto 0);
    
    signal R6       : STD_LOGIC;
    signal R5       : STD_LOGIC;
    signal R4       : STD_LOGIC;
    signal R3       : STD_LOGIC;
    signal R2       : STD_LOGIC;
    signal R1       : STD_LOGIC;
    signal R0       : STD_LOGIC;
    
    signal S_R6       : STD_LOGIC;
    signal S_R5       : STD_LOGIC;
    signal S_R4       : STD_LOGIC;
    signal S_R3       : STD_LOGIC;
    signal S_R2       : STD_LOGIC;
    signal S_R1       : STD_LOGIC;
    signal S_R0       : STD_LOGIC;

begin


end Behavioral;
