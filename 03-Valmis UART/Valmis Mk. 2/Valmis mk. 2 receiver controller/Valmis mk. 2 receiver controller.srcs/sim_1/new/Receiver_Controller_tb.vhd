library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Receiver_Controller_tb is
end Receiver_Controller_tb;

architecture Sim of Receiver_Controller_tb is
    
    signal t_clk            : STD_LOGIC := '0';
    signal t_y              : STD_LOGIC := '1';
    signal t_Ngt6           : STD_LOGIC := '0';
    
    signal t_ld_c           : STD_LOGIC := '0';
    signal t_t_ld           : STD_LOGIC := '0';
    signal t_N_sel          : STD_LOGIC := '0';
    signal t_N_ld           : STD_LOGIC := '0';
    
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
    
uut : entity work.Receiver_Controller
    port map(
        clk             => t_clk,
        y               => t_y,
        Ngt6            => t_Ngt6,
        ld_c            => t_ld_c,
        t_ld            => t_t_ld,
        N_sel           => t_N_sel,
        N_ld            => t_N_ld
    );
    
    process
    begin
    
        -- case when y = 0 in INIT
        t_y <= '0';
        
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_N_ld = '0' -- this is the only output that can be used to differentiate INIT and WAIT. So, it's the only proof of the controller's staying in INIT.
            report "FAIL! Controller failed to stay in INIT when y = 0."
            severity error;
        
        -- case when y = 1 in INIT
        t_y <= '1';
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_N_ld = '1'
            report "FAIL! Controller failed to move from INIT to WAIT when y = 1."
            severity error;
            
        -- case when y = 1 in WAIT
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert t_N_ld = '1'
            report "FAIL! Controller failed to remain in WAIT when y = 1."
            severity error;
            
        -- case when y = 0 in WAIT
        t_y <= '0';
        
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert(t_ld_c  = '1' and
               t_t_ld  = '0' and
               t_N_sel = '1' and
               t_N_ld  = '1')
           report "FAIL! Controller failed to move to RECEIVE from WAIT."
           severity error;
            
        -- case when Ngt6 = 0 in RECEIVE
        t_Ngt6 <= '0';
        
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert(t_ld_c  = '1' and
               t_t_ld  = '0' and
               t_N_sel = '1' and
               t_N_ld  = '1')
           report "FAIL! Controller failed to stay in RECEIVE."
           severity error;
           
       -- case when  Ngt6 = 1
       t_Ngt6 <= '1';
       t_y    <= '1'; -- the transmitter's output is designed to send y = 1 at this time
       
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert(t_ld_c  = '0' and
               t_t_ld  = '1' and
               t_N_sel = '0' and
               t_N_ld  = '1')
           report "FAIL! Controller failed to move to SHOW from RECEIVE."
           severity error;
       
       -- case when y = 1 in SHOW
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert(t_ld_c  = '0' and
               t_t_ld  = '1' and
               t_N_sel = '0' and
               t_N_ld  = '1')
           report "FAIL! Controller did not stay in SHOW when y = 1."
           severity error;
        
        -- case when y = 0 in SHOW
        t_y <= '0';
        
        for i in 1 to 10417 loop
            wait until rising_edge(t_clk);
        end loop;
        
        wait for 1 ns;
        
        assert(t_ld_c  = '1' and
               t_t_ld  = '0' and
               t_N_sel = '1' and
               t_N_ld  = '1')
            report "FAIL! Controller failed to return to RECEIVE from SHOW when y = 0."
            severity error;
            
        report "TEST SUCCESS!"
            severity note;
        wait;
    end process;
end Sim;
