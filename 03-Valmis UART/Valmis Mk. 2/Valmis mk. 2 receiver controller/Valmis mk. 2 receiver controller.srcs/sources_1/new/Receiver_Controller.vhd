library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Receiver_Controller is
    port(
        clk                 : in STD_LOGIC;
        y                   : in STD_LOGIC;
        Ngt5                : in STD_LOGIC;
        
        ld_c                : out STD_LOGIC;
        t_ld                : out STD_LOGIC;
        N_sel               : out STD_LOGIC;
        N_ld                : out STD_LOGIC
    );
end Receiver_Controller;

architecture Behavioral of Receiver_Controller is

    signal current_state    : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal next_state       : STD_LOGIC_VECTOR(1 downto 0);
    
    constant INIT_ST        : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant WAIT_ST        : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant RECEIVE_ST     : STD_LOGIC_VECTOR(1 downto 0) := "10";
    constant SHOW_ST        : STD_LOGIC_VECTOR(1 downto 0) := "11";
    
    signal controller_baud  : STD_LOGIC;

begin

    Baud_N          : entity work.Baud_Gen
        port map(
            clk         => clk,
            baud_tick   => controller_baud
        );
    
    process(clk)
    begin
        if rising_edge(clk) then
            if controller_baud = '1' then
                current_state <= next_state;
            end if;
        end if;
    end process;
        
        
    -- states
    process(all)
    begin
        next_state  <= INIT_ST;
        ld_c        <= '0';
        t_ld        <= '0';
        N_sel       <= '0';
        N_ld        <= '0';
        
        case current_state is
            when INIT_ST =>
                ld_c        <= '0';
                t_ld        <= '0';
                N_sel       <= '0';
                N_ld        <= '0';
                    
                -- Controller will never initialize until y=1
                if y = '1' then
                    next_state <= WAIT_ST;
                else
                    next_state <= INIT_ST;
                end if;
                
            when WAIT_ST =>
                ld_c        <= '0';
                t_ld        <= '0';
                N_sel       <= '0';
                N_ld        <= '1';
                
                if y = '1' then
                    next_state <= WAIT_ST;
                else
                    next_state <= RECEIVE_ST;
                end if;
                
            when RECEIVE_ST =>
                ld_c        <= '1';
                t_ld        <= '0';
                N_sel       <= '1';
                N_ld        <= '1';
               
                if Ngt5 = '0' then
                    next_state <= RECEIVE_ST;
                else
                    next_state <= SHOW_ST;
                end if;
                
            when SHOW_ST =>
                ld_c        <= '0';
                t_ld        <= '1';
                N_sel       <= '0';
                N_ld        <= '1';
                
                if y = '1' then
                    next_state <= SHOW_ST;
                else
                    next_state <= RECEIVE_ST;
                end if;
                
            when others =>
                next_state <= INIT_ST;
                
            end case;
        end process;                    
end Behavioral;
