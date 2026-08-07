library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Transmitter_tb is
end Transmitter_tb;

architecture Sim of Transmitter_tb is

    signal t_clk    : STD_LOGIC := '0';
    signal t_W      : STD_LOGIC_VECTOR(6 downto 0) := "1010011";
    signal t_data_in: STD_LOGIC := '0';
    signal t_y      : STD_LOGIC;
    
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
    
uut : entity work.Transmitter_7bit
    port map(
        clk         => t_clk,
        W           => t_W,
        data_in     => t_data_in,
        y           => t_y
    );
        
    process
    begin
        
        -- initial IDLE behavior of transmitter
        wait until rising_edge(t_clk);
        wait for 1 ns;
        
        -- wait another clock tick because controller and y register must update
        wait until rising_edge(t_clk);
        wait for 1 ns;
        
        -- y check
        assert t_y = '1'
            report "FAIL! Incorrect initial idle behavior."
            severity error;
            
        -- Begin transmission by raising data_in HIGH
        -- Wait for a full baud period this time instead
        -- For this first series, data_in will be kept HIGH
        t_data_in <= '1';
        
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        -- y check
        assert t_y = '0'
            report "FAIL! 0 START bit failed to send."
            severity error;
            
        -- Wait another full baud period to observe W LSB
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        -- y check
        assert t_y = t_W(0)
            report "FAIL! y does not match W(0)."
            severity error;
            
        -- Wait another full baud period to observe W(1)
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        -- y check
        assert t_y = t_W(1)
            report "FAIL! y does not match W(1)."
            severity error;
            
        -- Wait another full baud period to observe W(2)
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        -- y check
        assert t_y = t_W(2)
            report "FAIL! y does not match W(2)."
            severity error;
            
        -- Wait another full baud period to observe W(3)
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        -- y check
        assert t_y = t_W(3)
            report "FAIL! y does not match W(3)."
            severity error;
            
        -- Wait another full baud period to observe W(4)
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        -- y check
        assert t_y = t_W(4)
            report "FAIL! y does not match W(4)."
            severity error;
            
        -- Wait another full baud period to observe W(5)
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        -- y check
        assert t_y = t_W(5)
            report "FAIL! y does not match W(5)."
            severity error;
        
        -- Wait another full baud period to observe W(6)
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        -- y check
        assert t_y = t_W(6)
            report "FAIL! y does not match W(6)."
            severity error;
            
            
        -- check that the stop bit comes despite data_in's being still HIGH
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        -- y stop bit check
        assert t_y = '1'
            report "FAIL! Transmitter failed to give stop bit."
            severity error;
        
        -- set data_in LOW and observe whether idle bit persists
        t_data_in <= '0';
        
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        -- y idle bit check
        assert t_y = '1'
            report "FAIL! Transmitter failed to stay idle after data_in went LOW."
            severity error; 
        
        report "TEST SUCCESS!"
            severity note;
        wait;
    end process;
end Sim;
