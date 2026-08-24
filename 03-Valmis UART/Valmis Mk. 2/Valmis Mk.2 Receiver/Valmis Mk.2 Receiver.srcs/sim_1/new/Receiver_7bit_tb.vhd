library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Receiver_7bit_tb is
end Receiver_7bit_tb;

architecture Sim of Receiver_7bit_tb is

    signal t_clk    : STD_LOGIC := '0';
    signal t_y      : STD_LOGIC := '1';
    
    signal t_D      : STD_LOGIC_VECTOR(6 downto 0);
    
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
    
uut : entity work.Receiver_7bit
    port map(
        clk     => t_clk,
        y       => t_y,
        D       => t_D
    );
    
    process
    begin
        
        -- This testbench will test with ASCII value 110 1011
        -- test y=1 and wait a few cycles for initialization and idling
        t_y <= '1';
        for j in 1 to 3 loop
            for i in 1 to 10417 loop
                wait until rising_edge(t_clk);
            end loop;
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "0000000"
            report "FAIL! Incorrect IDLE behavior."
            severity error;
            
        -- send START bit
        t_y <= '0';
        
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "0000000"
            report "FAIL! Receiver responded to start bit incorrectly"
            severity error;
            
        -- send LSB of ASCII value 110 1011
        t_y <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "0000000"
            report "FAIL! Receiver erroneously showed a nonzero D value while receiving bit 0."
            severity error;
        
        -- send bit 1 of ASCII value 110 1011
        t_y <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "0000000"
            report "FAIL! Receiver erroneously showed a nonzero D value while receiving bit 1."
            severity error;
            
        -- send bit 2
        t_y <= '0';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "0000000"
            report "FAIL! Receiver erroneously showed a nonzero D value while receiving bit 2."
            severity error;
            
        -- send bit 3 of 110 1011
        t_y <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "0000000"
            report "FAIL! Receiver erroneously showed a nonzero D value while receiving bit 3."
            severity error;
            
        -- send bit 4 of 110 1011
        t_y <= '0';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "0000000"
            report "FAIL! Receiver erroneously showed a nonzero D value while receiving bit 4."
            severity error;
            
        -- send bit 5 of 110 1011
        t_y <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "0000000"
            report "FAIL! Receiver erroneously showed a nonzero D value while receiving bit 5."
            severity error;
            
        -- send bit 6 of 110 1011 and observe SHOW behavior
        t_y <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "1101011"
            report "FAIL! Receiver showed incorrect value."
            severity error;
            
        -- sustain show
        t_y <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "1101011"
            report "FAIL! Receiver failed to maintain correct value with idle from transmitter."
            severity error;
            
        -- reset D with a start bit
        t_y <= '0';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "0000000"
            report "FAIL! Receiver failed to reset D to 0."
            severity error;
        

        report "TEST SUCCESS!"
            severity note;
        wait;
    end process;
end Sim;
