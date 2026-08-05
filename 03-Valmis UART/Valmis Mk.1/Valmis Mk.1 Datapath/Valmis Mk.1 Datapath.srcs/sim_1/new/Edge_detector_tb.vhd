library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Edge_detector_tb is
end Edge_detector_tb;

architecture Sim of Edge_detector_tb is

    signal t_data_in: STD_LOGIC := '0';
    signal t_edetect: STD_LOGIC;
    signal t_clk    : STD_LOGIC := '0';

begin
    clk_process : process
    begin
        while true loop
            t_clk   <= '0';
            wait for 5 ns;
            t_clk   <= '1';
            wait for 5 ns;
        end loop;
    end process;

uut: entity work.Edge_detector
    port map(
        data_in => t_data_in,
        clk     => t_clk,
        edetect => t_edetect
    );
    
        process
        begin

        -- case when data_in = 0 in IDLE
        t_data_in   <= '0';
        wait until rising_edge(t_clk);
        wait for 1 ns;
        assert t_edetect = '1'
            report "Incorrect output. Failed to properly travel from state 00 to 00."
            severity error;
        
        -- case when data_in = 1 in IDLE
        t_data_in   <= '1';
        wait until rising_edge(t_clk);
        wait for 1 ns;
        assert t_edetect = '0'
            report "Incorrect output. Failed to properly travel from state 00 to 01."
            severity error;
            
        -- observe behavior from 01 to 10
        wait until rising_edge(t_clk);
        wait for 1 ns;
        assert t_edetect = '1'
            report "Incorrect output. Failed to properly travel from state 01 to 10."
            severity error;
            
        -- case when data_in = 1 in FINISH
        t_data_in   <= '1';
        wait until rising_edge(t_clk);
        wait for 1 ns;
        assert t_edetect = '1'
            report "Incorrect output. Failed to properly travel from state 10 to 10."
            severity error;
            
        -- case when data_in = 0 in FINISH
        t_data_in   <= '0';
        wait until rising_edge(t_clk);
        wait for 1 ns;
        assert t_edetect = '1'
            report "Incorrect output. Failed to properly travel from state 10 to 00."
            severity error;
        
        report "TEST SUCCESS!"
            severity note;
        wait;
    end process;
end Sim;
