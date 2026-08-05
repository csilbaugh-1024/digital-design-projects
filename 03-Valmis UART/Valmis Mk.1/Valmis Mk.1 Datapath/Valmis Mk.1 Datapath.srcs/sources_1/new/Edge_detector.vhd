library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Edge_detector is
    port(
        clk     : in STD_LOGIC;
        data_in : in STD_LOGIC;
        edetect : out STD_LOGIC
        );   
end Edge_detector;

architecture Behavioral of Edge_detector is
    
    constant IDLE_ST    : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant START_ST   : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant FINISH_ST  : STD_LOGIC_VECTOR(1 downto 0) := "10";
    
    signal current_state: STD_LOGIC_VECTOR(1 downto 0) := IDLE_ST;
    signal next_state   : STD_LOGIC_VECTOR(1 downto 0);
    
begin

    -- state register behavior
    process(clk)
    begin
        if rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    -- state change behavior
    process(all)
    begin
        next_state  <= IDLE_ST;
        edetect           <= '1';
        
        case current_state is
            when IDLE_ST =>
                edetect   <= '1';
                if data_in = '0' then
                    next_state <= IDLE_ST;
                else
                    next_state <= START_ST;
                end if;
                
            when START_ST =>
                edetect   <= '0';
                next_state <= FINISH_ST;
                
            when FINISH_ST =>
                edetect   <= '1';
                if data_in = '1' then
                    next_state <= FINISH_ST;
                else
                    next_state <= IDLE_ST;
                end if;
                
            when others =>
                edetect   <= '1';
                next_state <= IDLE_ST;
        end case;
    end process;
end architecture Behavioral;
