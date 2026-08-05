library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controller is
    port(
        clk         : in STD_LOGIC;
        data_in     : in STD_LOGIC;
        Igt6        : in STD_LOGIC;
        I_sel       : out STD_LOGIC;
        W_sel       : out STD_LOGIC;
        I_ld        : out STD_LOGIC;
        W_ld        : out STD_LOGIC;
        y_sel       : out STD_LOGIC;
        y_ld        : out STD_LOGIC;
        p1NOT       : out STD_LOGIC
    );
end Controller;

architecture Behavioral of Controller is

    signal current_state    : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal next_state       : STD_LOGIC_VECTOR(1 downto 0);
    constant IDLE_ST        : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant START_ST       : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant SEND_ST        : STD_LOGIC_VECTOR(1 downto 0) := "10";

begin

    process(clk)
    begin
        if rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    -- states behavior
    process(all)
    begin
        next_state  <= IDLE_ST;
        I_sel       <= '0';
        I_ld        <= '0';
        W_sel       <= '0';
        W_ld        <= '0';
        y_sel       <= '0';
        y_ld        <= '1';
        
        case current_state is
            when IDLE_ST =>
                I_sel       <= '0';
                I_ld        <= '0';
                W_sel       <= '0';
                W_ld        <= '0';
                y_sel       <= '0';
                y_ld        <= '1';
                if data_in = '0' then
                    next_state <= IDLE_ST;
                else
                    next_state <= START_ST;
                end if;
                
            when START_ST =>
                I_sel       <= '0';
                I_ld        <= '1';
                W_sel       <= '0';
                W_ld        <= '1';
                y_sel       <= '0';
                y_ld        <= '1';
                next_state <= SEND_ST;
                
            when SEND_ST =>
                I_sel       <= '1';
                I_ld        <= '1';
                W_sel       <= '1';
                W_ld        <= '1';
                y_sel       <= '1';
                y_ld        <= '1';
                if Igt6 = '1' then
                    next_state <= IDLE_ST;
                else
                    next_state <= SEND_ST;
                end if;
            
            when others =>
                I_sel       <= '0';
                I_ld        <= '0';
                W_sel       <= '0';
                W_ld        <= '0';
                y_sel       <= '0';
                y_ld        <= '0';
                next_state <= IDLE_ST;
            end case;
        end process;
    
p1NOT <= not current_state(0);
        
end Behavioral;
