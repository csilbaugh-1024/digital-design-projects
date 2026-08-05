library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shift_Right_1_tb is
end Shift_Right_1_tb;

architecture Sim of Shift_Right_1_tb is
    
    signal t_A  : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal t_B  : STD_LOGIC_VECTOR(6 downto 0);
    
begin

uut: entity work.Shift_Right_1
    port map(
        A   => t_A,
        B   => t_B
    );
    
    process
    begin
    
        -- test with all 0
        wait for 10 ns;
        assert t_B = "1000000"
            report "FAIL! Incorrect Shift"
            severity error;
            
        -- test with all 1
        t_A <= "1111111";
        wait for 10 ns;
        assert t_B = "1111111"
            report "FAIL! Incorrect Shift"
            severity error;
        
        -- test with arbitrary A value
        t_A <= "0110100";
        wait for 10 ns;
        assert t_B = "1011010"
            report "FAIL! Incorrect Shift"
            severity error;
        
        report "TEST SUCCESS!"
            severity note;
        wait;
    end process;
end Sim;
