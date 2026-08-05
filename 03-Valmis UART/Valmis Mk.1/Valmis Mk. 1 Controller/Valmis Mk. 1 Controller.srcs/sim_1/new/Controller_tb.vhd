library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controller_tb is
end Controller_tb;

architecture Sim of Controller_tb is

    signal t_clk          : STD_LOGIC := '0';
    signal t_data_in      : STD_LOGIC := '0';
    signal t_Igt6         : STD_LOGIC := '0';
    signal t_I_sel        : STD_LOGIC := '0'; 
    signal t_W_sel        : STD_LOGIC := '0';
    signal t_I_ld         : STD_LOGIC := '0';
    signal t_W_ld         : STD_LOGIC := '0';
    signal t_y_sel        : STD_LOGIC := '0';
    signal t_y_ld         : STD_LOGIC := '1';
    signal t_p1NOT        : STD_LOGIC := '1';
    
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
    
uut : entity work.Controller
    port map(
        clk         => t_clk,
        data_in     => t_data_in,
        Igt6        => t_Igt6,
        I_sel       => t_I_sel,
        W_sel       => t_W_sel,
        I_ld        => t_I_ld,
        W_ld        => t_W_ld,
        y_sel       => t_y_sel,
        y_ld        => t_y_ld,
        p1NOT       => t_p1NOT
    );
    
    process
    begin
    
        -- case when data_in = 0 in IDLE
        t_data_in <= '0';
        wait until rising_edge(t_clk);
        wait for 1 ns;
    
        --  NOT p1 check
        assert t_p1NOT = '1'
           report "FAIL! Incorrect NOT p1 output in IDLE."
           severity error;
    
        -- controller output check
        assert  (t_I_sel    = '0' and
                 t_I_ld     = '0' and
                 t_W_sel    = '0' and
                 t_W_ld     = '0' and
                 t_y_sel    = '0' and
                 t_y_ld     = '1')
            report "FAIL! Incorrect select and load outputs in IDLE."
            severity error;
    
        -- case when data_in = 1 in IDLE
        t_data_in <= '1';
        wait until rising_edge(t_clk);
        wait for 1 ns;
    
        -- edge detector check
        assert t_p1NOT = '0'
            report "FAIL! Incorrect NOT p1 output in START."
            severity error;
    
        -- controller output check
        assert  (t_I_sel    = '0' and
                 t_I_ld     = '1' and
                 t_W_sel    = '0' and
                 t_W_ld     = '1' and
                 t_y_sel    = '0' and
                 t_y_ld     = '1')
            report "FAIL! Incorrect select and load outputs in START."
            severity error;
    
        -- case in SEND when Igt6 = 0 and data_in does not change
        wait until rising_edge(t_clk);
        wait for 1 ns;
        
        -- NOT p1 check (the output is a don't care in this state because y_sel = 1.)
        assert t_p1NOT = '1'
            report "FAIL! Incorrect NOT p1 output in SEND"
            severity error;
        
        -- controller output check
        assert  (t_I_sel    = '1' and
                t_I_ld     = '1' and
                t_W_sel    = '1' and
                t_W_ld     = '1' and
                t_y_sel    = '1' and
                t_y_ld     = '1')
            report "FAIL! Incorrect select and load outputs in SEND."
            severity error;
        
        -- verify that SEND persists while Igt6 = 0
        t_Igt6 <= '0';
        wait until rising_edge(t_clk);
        wait for 1 ns;
        
        -- NOT p1 check (the output is a don't care in this state because y_sel = 1.)
        assert t_p1NOT = '1'
            report "FAIL! Incorrect NOT p1 output while SEND persists."
            severity error;
        
        -- controller output check
        assert  (t_I_sel    = '1' and
                t_I_ld     = '1' and
                t_W_sel    = '1' and
                t_W_ld     = '1' and
                t_y_sel    = '1' and
                t_y_ld     = '1')
            report "FAIL! Incorrect select and load outputs while SEND persists."
            severity error;
        
        -- case in SEND when Igt6 = 1 and data_in does not change
        t_Igt6 <= '1';
        wait until rising_edge(t_clk);
        wait for 1 ns;
        
        -- NOT p1 check (the output is a don't care in this state because y_sel = 1.)
        assert t_p1NOT = '1'
            report "FAIL! Incorrect edge detector output in SEND"
            severity error;
    
        -- controller output check
        assert  (t_I_sel    = '0' and
                t_I_ld     = '0' and
                t_W_sel    = '0' and
                t_W_ld     = '0' and
                t_y_sel    = '0' and
                t_y_ld     = '1')
            report "FAIL! Incorrect select and load outputs in SEND."
            severity error;
        
        report "TEST SUCCESS!"
            severity note;
        wait;
    end process;
end Sim;
