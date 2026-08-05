library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Incrementer_tb is
end Incrementer_tb;

architecture Sim of Incrementer_tb is
    
    signal t_A  : STD_LOGIC_VECTOR(2 downto 0);
    signal t_B  : STD_LOGIC_VECTOR(2 downto 0);
    
begin

uut: entity work.Incrementer
    port map(
        A   => t_A,
        B   => t_B
    );
    
        process
        begin
            -- standard case
            t_A <= "000";
            wait for 10 ns;
            assert t_B = "001"
                report "FAIL! Did not properly increment."
                severity error;
            
            -- overflow case
            t_A <= "111";
            wait for 10 ns;
            assert t_B = "000"
                report "FAIL! Overflow increment failed."
                severity error;
            
            report "TEST SUCCESS!"
                severity note;
            wait;
        end process;
end Sim;
