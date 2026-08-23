library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath_Receiver is
    port(
        ld_c            : in STD_LOGIC;
        t_ld            : in STD_LOGIC;
        N_sel           : in STD_LOGIC;
        N_ld            : in STD_LOGIC;
        y               : in STD_LOGIC;
        clk             : in STD_LOGIC;
        
        Ngt6            : out STD_LOGIC;
        D               : out STD_LOGIC_VECTOR(6 downto 0)
    );
end Datapath_Receiver;

architecture Behavioral of Datapath_Receiver is

    signal N_mux            : STD_LOGIC_VECTOR(2 downto 0);
    signal N_reg            : STD_LOGIC_VECTOR(2 downto 0);
    signal N_inc            : STD_LOGIC_VECTOR(2 downto 0);
    
    signal R6               : STD_LOGIC;
    signal R5               : STD_LOGIC;
    signal R4               : STD_LOGIC;
    signal R3               : STD_LOGIC;
    signal R2               : STD_LOGIC;
    signal R1               : STD_LOGIC;
    signal R0               : STD_LOGIC;
    
    signal S_R6             : STD_LOGIC;
    signal S_R5             : STD_LOGIC;
    signal S_R4             : STD_LOGIC;
    signal S_R3             : STD_LOGIC;
    signal S_R2             : STD_LOGIC;
    signal S_R1             : STD_LOGIC;
    signal S_R0             : STD_LOGIC;
    
    signal receiver_baud    : STD_LOGIC;
    
begin

    Mux_N           : entity work.Mux_2x1_N
        port map(
            A   => "000",
            B   => N_inc,
            sel => N_sel,
            C   => N_mux
        );
        
    Incrementer_N   : entity work.N_Incrementer
        port map(
            A   => N_reg,
            B   => N_inc
        );
    
    Comparator_N    : entity work.N_comparator
        port map(
            A   => N_reg,
            B   => "110",
            Ngt => Ngt6
        );
        
    Baud_N          : entity work.Baud_Gen
        port map(
            clk         => clk,
            baud_tick   => receiver_baud
        );
        
        
    process(clk)
    begin
        if rising_edge(clk) then
            if receiver_baud = '1' then
                -- Trickle down register tree
                if ld_c = '1' then
                    R6 <= y;
                    R5 <= R6;
                    R4 <= R5;
                    R3 <= R4;
                    R2 <= R3;
                    R1 <= R2;
                    R0 <= R1;
                end if;
                
                -- SEND REGISTER
                if t_ld = '1' then
                    S_R6 <= R6;
                    S_R5 <= R5;
                    S_R4 <= R4;
                    S_R3 <= R3;
                    S_R2 <= R2;
                    S_R1 <= R1;
                    S_R0 <= R0;
                end if;
                
                -- N register
                if N_ld = '1' then
                    N_reg <= N_mux;
                end if;
            end if;
        end if;
    end process;
    
    D(6) <= S_R6 and t_ld;
    D(5) <= S_R5 and t_ld;
    D(4) <= S_R4 and t_ld;
    D(3) <= S_R3 and t_ld;
    D(2) <= S_R2 and t_ld;
    D(1) <= S_R1 and t_ld;
    D(0) <= S_R0 and t_ld;

end Behavioral;
