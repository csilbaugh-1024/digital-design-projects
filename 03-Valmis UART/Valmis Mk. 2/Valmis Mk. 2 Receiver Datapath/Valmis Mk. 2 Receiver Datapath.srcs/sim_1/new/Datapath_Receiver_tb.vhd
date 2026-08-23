library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath_Receiver_tb is
end Datapath_Receiver_tb;

architecture Sim of Datapath_Receiver_tb is

    signal t_ld_c   : STD_LOGIC := '0';
    signal t_t_ld   : STD_LOGIC := '0';
    signal t_N_sel  : STD_LOGIC := '0';
    signal t_N_ld   : STD_LOGIC := '0';
    signal t_y      : STD_LOGIC := '1';
    signal t_clk    : STD_LOGIC := '0';
    
    signal t_Ngt6     : STD_LOGIC := '0';
    signal t_D        : STD_LOGIC_VECTOR(6 downto 0);

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


uut : entity work.Datapath_Receiver
    port map(
        ld_c        => t_ld_c,
        t_ld        => t_t_ld,
        N_sel       => t_N_sel,
        N_ld        => t_N_ld,
        y           => t_y,
        clk         => t_clk,
        Ngt6        => t_Ngt6,
        D           => t_D
    );
        
    process
    begin
        
        -- wait a few baud ticks to let initialization finish
        for j in 1 to 3 loop
            for i in 1 to 10417 loop
                wait until rising_edge(t_clk);
            end loop;
        end loop;
        
        wait for 1 ns;
        
        -- test case when IDLE and y=1
        t_y <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
            
        wait for 1 ns;
            
        assert t_D = "0000000"
            report "FAIL! Incorrect IDLE behavior."
            severity error;
            
        -- test case when send start bit. Nothing should change.
        t_y <= '0';
        t_ld_c  <= '0';  
        t_N_sel <= '0';
        t_N_ld  <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_Ngt6 = '0'
            report "FAIL! Comparator fired while receiving start bit."
            severity error;
        
        assert t_D = "0000000"
            report "FAIL! Incorrect response to start bit."
            severity error;
            
        -- test with bit 0 of 7-bit ASCII word "011 1011"
        t_y     <= '1';
        t_ld_c  <= '1';  
        t_N_sel <= '1';
        t_N_ld  <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_D = "0000000"
            report "FAIL! Incorrect output while receiving bit 0."
            severity error;
        
        assert t_Ngt6 = '0'
            report "FAIL! Comparator fired before N exceeded 6 while receiving bit 0."
            severity error;
            
        -- receive bit 1 and begin incrementing N
        t_y     <= '1';
        t_ld_c  <= '1';  
        t_N_sel <= '1';
        t_N_ld  <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
            
        assert t_Ngt6 = '0'
            report "FAIL! Comparator fired before N exceeded 6 while receiving bit 1."
            severity error;
            
        assert t_D = "0000000"
            report "FAIL! Incorrect output while receiving bit 1."
            severity error;
            
        -- receive bit 2
        t_y     <= '0';
        t_ld_c  <= '1';  
        t_N_sel <= '1';
        t_N_ld  <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
            
        assert t_Ngt6 = '0'
            report "FAIL! Comparator fired before N exceeded 6 while receiving bit 2."
            severity error;
            
        assert t_D = "0000000"
            report "FAIL! Incorrect output while receiving bit 2."
            severity error;  
            
        -- receive bit 3 of "011 1011"
        t_y     <= '1';
        t_ld_c  <= '1';  
        t_N_sel <= '1';
        t_N_ld  <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
            
        assert t_Ngt6 = '0'
            report "FAIL! Comparator fired before N exceeded 6 while receiving bit 3."
            severity error;
            
        assert t_D = "0000000"
            report "FAIL! Incorrect output while receiving bit 3."
            severity error;  
            
        -- receive bit 4
        t_y     <= '1';
        t_ld_c  <= '1';  
        t_N_sel <= '1';
        t_N_ld  <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
            
        assert t_Ngt6 = '0'
            report "FAIL! Comparator fired before N exceeded 6 while receiving bit 4."
            severity error;
            
        assert t_D = "0000000"
            report "FAIL! Incorrect output while receiving bit 4."
            severity error; 
            
        -- receive bit 5
        t_y     <= '1';
        t_ld_c  <= '1';  
        t_N_sel <= '1';
        t_N_ld  <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
            
        assert t_Ngt6 = '0'
            report "FAIL! Comparator fired before N exceeded 6 while receiving bit 5."
            severity error;
            
        assert t_D = "0000000"
            report "FAIL! Incorrect output while receiving bit 5."
            severity error; 
            
        -- receive final bit, bit 6, of "011 1011"
        t_y     <= '0';
        t_ld_c  <= '1';  
        t_N_sel <= '1';
        t_N_ld  <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
            
        assert t_Ngt6 = '1'
            report "FAIL! Comparator failed to fire when N exceeded 6"
            severity error;
            
        assert t_D = "0000000"
            report "FAIL! Incorrect output while receiving bit 6."
            severity error;
            
        -- Move to SHOW state and receive y=1
        t_y     <= '1';
        t_ld_c  <= '0';  
        t_N_sel <= '0';
        t_N_ld  <= '1';
        
        t_t_ld  <= '1'; -- only in the SHOW state does the terminal load go HIGH
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
            
        assert t_Ngt6 = '0'
            report "FAIL! Increment N loop failed to reset in SHOW state."
            severity error;
            
        assert t_D = "0111011"
            report "FAIL! Incorrect output in SHOW state."
            severity error;
            
        -- return to IDLE
        t_y     <= '1';
        t_ld_c  <= '0';  
        t_N_sel <= '0';
        t_N_ld  <= '1';
        
        t_t_ld  <= '0'; -- only in the SHOW state does the terminal load go HIGH
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
            
        assert t_Ngt6 = '0'
            report "FAIL! Increment N loop failed to reset after leaving SHOW state."
            severity error;
            
        assert t_D = "0000000"
            report "FAIL! D failed to return to 000 0000 after returning to IDLE from SHOW."
            severity error;
            
         
        report "TEST SUCCESS!"
            severity note;
        wait;
    end process;
end Sim;
