library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath_tb is
end Datapath_tb;

architecture Sim of Datapath_tb is

    signal t_I_sel      : STD_LOGIC := '0';
    signal t_W_sel      : STD_LOGIC := '0';
    signal t_I_ld       : STD_LOGIC := '0';
    signal t_W_ld       : STD_LOGIC := '0';
    signal t_y_sel      : STD_lOGIC := '0';
    signal t_y_ld       : STD_LOGIC := '1';
    signal t_edetectNOT : STD_LOGIC := '1';
    signal t_W          : STD_LOGIC_VECTOR(6 downto 0);
    signal t_clk        : STD_LOGIC := '0';
    signal t_Igt6       : STD_LOGIC := '0';
    signal t_y          : STD_LOGIC;
    
begin

uut: entity work.Datapath
    port map(
        I_sel       => t_I_sel,
        W_sel       => t_W_sel,
        I_ld        => t_I_ld,
        W_ld        => t_W_ld,
        y_sel       => t_y_sel,
        y_ld        => t_y_ld,
        edetectNOT  => t_edetectNOT,
        W           => t_W,
        clk         => t_clk,
        Igt6        => t_Igt6,
        y           => t_y
    );
    
    clk_process : process
    begin
        while true loop
            t_clk <= '0';
            wait for 5 ns;
            t_clk <= '1';
            wait for 5 ns;
        end loop;
    end process;
    
        process
            variable expected_W : STD_LOGIC_VECTOR(6 downto 0);
        begin

        t_W <= "0110101"; -- set arbitrary W value
        expected_W := "0110101"; -- expected W to observe shifting behavior
        
        -- WAIT situation
        t_I_sel     <= '0';
        t_I_ld      <= '0';
        t_W_sel     <= '0';
        t_W_ld      <= '0';
        t_y_sel     <= '0';
        t_y_ld      <= '1';
        t_edetectNOT<= '1';
        wait until rising_edge(t_clk);
        wait for 1 ns;
        assert t_y = '1'
            report "FAIL! Failure in state WAIT."
            severity error;
            
        -- Transition from WAIT to START
        t_I_sel     <= '0';
        t_I_ld      <= '1';
        t_W_sel     <= '0';
        t_W_ld      <= '1';
        t_y_sel     <= '0';
        t_y_ld      <= '1';
        t_edetectNOT<= '0';
        wait until rising_edge(t_clk);
        wait for 1 ns;
        assert t_y = '0'
            report "FAIL! Failure in state START."
            severity error;
            
        -- Transition from START to SEND and SEND behavior
        for i in 0 to 6 loop
        
            t_I_sel     <= '1';
            t_I_ld      <= '1';
            t_W_sel     <= '1';
            t_W_ld      <= '1';
            t_y_sel     <= '1';
            t_y_ld      <= '1';
            t_edetectNOT<= '1';
            
            wait until rising_edge(t_clk);
            wait for 1 ns;
            
            assert t_y = expected_W(0)
                report "FAIL! Datapath did not pass correct W value."
                severity error;
            expected_W := expected_W(5 downto 0) & '1'; -- update expected W after another shift
        end loop;
        
        -- Transition from SEND to WAIT
        -- Observes whether Igt6 iterates correctly to move states when transmit done
        
        t_I_sel     <= '1';
        t_I_ld      <= '1';
        t_W_sel     <= '1';
        t_W_ld      <= '1';
        t_y_sel     <= '1';
        t_y_ld      <= '1';
        t_edetectNOT<= '1';
            
        wait until rising_edge(t_clk);
        wait for 1 ns;
        
        assert t_y = '1'
            report "FAIL! Failure returning to WAIT, possible problem with Igt6 iteration."
            severity error;
        
        report "TEST SUCCESS!"
            severity note;
        wait;
    end process;
end Sim;
