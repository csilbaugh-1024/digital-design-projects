library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2x1_7bit_tb is
end Mux_2x1_7bit_tb;

architecture Sim of Mux_2x1_7bit_tb is

    signal t_A  : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal t_B  : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal t_sel: STD_LOGIC := '0';
    signal t_C  : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');

begin

uut: entity work.Mux_2x1_7bit
    port map(
        A   => t_A,
        B   => t_B,
        sel => t_sel,
        C   => t_C
    );
        
        process
        begin
            -- Case sel=0
            t_A     <= "0011000";
            t_B     <= "0100000";
            t_sel     <= '0';
            wait for 10 ns;
            
            assert t_C = "0011000"
                report "FAIL! Mux failed to pass correct input"
                severity error;
                
            -- Case sel=1
            t_A     <= "0011000";
            t_B     <= "0100000";
            t_sel     <= '1';
            wait for 10 ns;
            
            assert t_C = "0100000"
                report "FAIL! Mux failed to pass correct input"
                severity error;
            
            report "TEST DONE!"
                severity note;
            wait;
        end process;
end Sim;