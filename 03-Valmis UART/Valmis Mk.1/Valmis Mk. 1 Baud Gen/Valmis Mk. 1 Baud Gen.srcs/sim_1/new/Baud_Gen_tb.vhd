library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Baud_Gen_tb is
end Baud_Gen_tb;

architecture Sim of Baud_Gen_tb is
    
    signal t_clk        : STD_LOGIC := '0';
    signal t_baud_tick  : STD_LOGIC := '0';
    constant COUNT_THRESH : integer := 10416;

begin
    clk_process : process
    begin
        while true loop
            t_clk <= '0';
            wait for 5 ns;
            t_clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

uut : entity work.Baud_Gen
    port map(
        clk         => t_clk,
        baud_tick   => t_baud_tick
    );
    
    process
    begin
    
        -- verify that baud stays low until tick
        for i in 0 to COUNT_THRESH-1 loop
            wait until rising_edge(t_clk);
            wait for 1 ns;
        
        assert t_baud_tick = '0'
            report "FAIL! Baud generator failed to stay low before proper tick moment."
            severity error;
        end loop;

        -- verify baud pulse at proper time
        wait until rising_edge(t_clk);
        wait for 1 ns;
        
        assert t_baud_tick = '1'
            report "FAIL! Baud failed to tick at proper time."
            severity error;
        
        -- verify baud returns low
        wait until rising_edge(t_clk);
        wait for 1 ns;
        
        assert t_baud_tick = '0'
            report "FAIL! Baud failed to return low after tick."
            severity error;
            
        report "TEST SUCCESS!"
            severity note;
            
        assert false
            report "Simulation finished."
            severity failure;
        wait;
    end process; 
end Sim;
