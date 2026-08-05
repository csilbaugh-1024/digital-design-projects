library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath is
    port(
        I_sel       : in STD_LOGIC;
        W_sel       : in STD_LOGIC;
        I_ld        : in STD_LOGIC;
        W_ld        : in STD_LOGIC;
        y_sel       : in STD_LOGIC;
        y_ld        : in STD_LOGIC;
        edetectNOT  : in STD_LOGIC;
        W           : in STD_LOGIC_VECTOR(6 downto 0);
        clk         : in STD_LOGIC;
        Igt6        : out STD_LOGIC;
        y           : out STD_LOGIC
    );
end Datapath;

architecture Behavioral of Datapath is

    signal W_mux        : STD_LOGIC_VECTOR(6 downto 0);
    signal W_reg        : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal shift_out    : STD_LOGIC_VECTOR(6 downto 0);
    signal y_mux        : STD_LOGIC;
    signal y_reg        : STD_LOGIC := '1';
    signal I_mux        : STD_LOGIC_VECTOR(2 downto 0);
    signal I_reg        : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal I_inc        : STD_LOGIC_VECTOR(2 downto 0);

begin

    Incrementer0    : entity work.Incrementer
        port map(
            A => I_reg,
            B => I_inc
        );
        
    Comparator0     : entity work.comp_3bit
        port map(
            A => I_reg,
            B => "110",
            gt=> Igt6
        );
        
    Shifter0        : entity work.Shift_Right_1
        port map(
            A => W_reg,
            B => shift_out
        );
            
    Mux_w           : entity work.Mux_2x1_7bit
        port map(
            A   => W,
            B   => shift_out,
            sel => W_sel,
            C   => W_mux
        );
        
    Mux_I           : entity work.Mux_2x1_3bit
        port map(
            A   => "000",
            B   => I_inc,
            sel => I_sel,
            C   => I_mux
        );
        
    Mux_y           : entity work.Mux_2x1
        port map(
            A   => edetectNOT,
            B   => W_reg(0),
            sel => y_sel,
            C   => y_mux
        );
    
    process(clk)
    begin
        if rising_edge(clk) then
            
            -- W reg behavior
            if W_ld = '1' then
                W_reg <= W_mux;
            end if;
            
            -- I reg behavior
            if I_ld = '1' then
                I_reg <= I_mux;
            end if;
            
            -- y reg behavior
            if y_ld = '1' then
                y_reg <= y_mux;
            end if;
        end if; 
    end process;
    
    y <= y_reg;
    
end Behavioral;
