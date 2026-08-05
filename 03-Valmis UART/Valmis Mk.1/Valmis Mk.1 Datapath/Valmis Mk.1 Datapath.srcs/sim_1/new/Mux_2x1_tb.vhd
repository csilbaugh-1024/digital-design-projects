library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2x1_tb is
end Mux_2x1_tb;

architecture Sim of Mux_2x1_tb is

    signal t_A  : STD_LOGIC := '0';
    signal t_B  : STD_LOGIC := '0';
    signal t_sel: STD_LOGIC := '0';
    signal t_C  : STD_LOGIC := '0';

begin

uut: entity work.Mux_2x1
    port map(
        A   => t_A,
        B   => t_B,
        sel => t_sel,
        C   => t_C
    );
        
        process
        begin
            -- Case sel=0
            t_A     <= '0';
            t_B     <= '1';
            t_sel     <= '0';
            wait for 10 ns;
            
            assert t_C = '0'
                report "FAIL! Mux failed to pass correct input"
                severity error;
                
            -- Case sel=1
            t_A     <= '0';
            t_B     <= '1';
            t_sel     <= '1';
            wait for 10 ns;
            
            assert t_C = '1'
                report "FAIL! Mux failed to pass correct input"
                severity error;
            
            report "TEST SUCCESS!"
                severity note;
            wait;
        end process;
end Sim;
