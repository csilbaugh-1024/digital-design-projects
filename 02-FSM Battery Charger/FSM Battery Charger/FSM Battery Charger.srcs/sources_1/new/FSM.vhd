library ieee;
use ieee.std_logic_1164.all;

entity FSM is
    port(
        clk : in STD_LOGIC;
        f   : in STD_LOGIC;
        b   : in STD_LOGIC;
        c   : out STD_LOGIC;
        d   : out STD_LOGIC
    );
end FSM;

architecture behavioral of FSM is

    signal current_state, next_state : STD_LOGIC_VECTOR(1 downto 0);
    constant WAIT_ST    : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant CHRG_ST    : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant DONE_ST    : STD_LOGIC_VECTOR(1 downto 0) := "10";

begin

    -- sequential register behavior
    process(clk)
    begin
        if rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    -- combinational controller behavior
    process(current_state, f, b)
    begin
        next_state  <= WAIT_ST;
        c           <= '0';
        d           <= '0';
        
        case current_state is
            when WAIT_ST =>
                c   <= '0';
                d   <= '0';
                if b = '1' and f = '0' then
                    next_state <= CHRG_ST;
                else
                    next_state <= WAIT_ST;
                end if;
            
            when CHRG_ST =>
                c   <= '1';
                d   <= '0';
                if b = '1' and f = '0' then
                    next_state <= CHRG_ST;
                elsif b = '1' and f = '1' then
                    next_state <= DONE_ST;
                else
                    next_state <= WAIT_ST;
                end if;
                
            when DONE_ST =>
                c   <= '0';
                d   <= '1';
                if b = '1' and f = '0' then
                    next_state <= CHRG_ST;
                elsif b = '1' and f = '1' then
                    next_state <= DONE_ST;
                else
                    next_state <= WAIT_ST;
                end if;
                
            when others =>
                c   <= '0';
                d   <= '0';
                next_state <= WAIT_ST;
        end case;
    end process;
end architecture behavioral;       


